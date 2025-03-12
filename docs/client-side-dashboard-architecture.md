# Client-Side Dashboard Architecture Guide

## Overview

This document outlines the architecture and implementation details of our client-side dashboard system. The architecture is designed to provide an instant, app-like experience with persistent UI elements and immediate visual feedback, even when data is still loading.

## Key Features

- **Persistent Sidebar**: Remains in place during navigation, providing a stable UI
- **Instant Visual Feedback**: Immediate response to user interactions
- **Client-Side Tab Switching**: Handles tab changes without full page reloads
- **Progressive Loading**: Shows skeleton screens while content loads
- **Event-Based Communication**: Components communicate via custom events
- **URL State Management**: Maintains deep-linking and shareable URLs

## Architecture Components

### 1. ClientDashboardLayout

The `ClientDashboardLayout` is the core component that orchestrates the entire dashboard experience. It:

- Renders the persistent sidebar
- Manages the header content
- Handles tab state changes
- Coordinates between sidebar and content area
- Maintains URL state for deep linking

```typescript
// Key implementation details
export function ClientDashboardLayout({
  initialContent,  // Server-rendered initial content
  currentTab,      // Initial tab from URL
  missionaryId,    // User ID for data fetching
  availableTabs,   // Available tabs for navigation
  isCampusDirector, // Role-based access control
  // ... other props
}) {
  // State management for client-side UI
  const [activeTab, setActiveTab] = useState(currentTab);
  const [isLoading, setIsLoading] = useState(false);
  
  // Listen for tab change events from sidebar
  useEffect(() => {
    const handleTabChange = (event: CustomEvent) => {
      const { tab } = event.detail;
      setActiveTab(tab);
      setIsLoading(true);
    };
    
    window.addEventListener('tabchange', handleTabChange as EventListener);
    return () => {
      window.removeEventListener('tabchange', handleTabChange as EventListener);
    };
  }, []);
  
  // Render persistent layout with sidebar and content area
  return (
    <div className="flex min-h-screen">
      {/* Persistent Sidebar */}
      <Sidebar isCampusDirector={isCampusDirector} />
      
      {/* Main Content Area */}
      <div className="flex-1 lg:ml-64">
        {/* Header */}
        <motion.div>...</motion.div>
        
        {/* Tab Content with transitions */}
        <PageTransition>
          <ClientTabSwitcher
            initialContent={initialContent}
            currentTab={activeTab}
            // ... other props
          />
        </PageTransition>
      </div>
    </div>
  );
}
```

### 2. Sidebar Component

The `Sidebar` component provides navigation and instant visual feedback:

- Renders navigation items based on user role
- Handles client-side navigation
- Shows loading indicators for active tab
- Dispatches events to coordinate with other components
- Supports both mobile and desktop layouts

```typescript
// Key implementation details
function SidebarContent({ isCampusDirector, /* ... */ }) {
  // State for active tab and loading state
  const [activeTab, setActiveTab] = useState(currentTab);
  const [loadingTab, setLoadingTab] = useState<string | null>(null);
  
  // Handle tab navigation
  const handleNavigation = (e, href) => {
    e.preventDefault();
    
    // Extract tab from href
    const newTab = extractTabFromHref(href);
    
    // Update UI state immediately
    setActiveTab(newTab);
    setLoadingTab(newTab);
    
    // Dispatch event for other components
    const tabChangeEvent = new CustomEvent('tabchange', { 
      detail: { tab: newTab, userId } 
    });
    window.dispatchEvent(tabChangeEvent);
    
    // Navigate via router
    router.push(constructUrl(newTab));
    
    // Reset loading state after delay
    setTimeout(() => setLoadingTab(null), 500);
  };
  
  // Render navigation items with loading indicators
  return (
    <>
      {/* Mobile sidebar */}
      <Sheet>...</Sheet>
      
      {/* Desktop sidebar */}
      <div className="hidden lg:flex lg:flex-col lg:fixed...">
        {/* Navigation items with loading indicators */}
      </div>
    </>
  );
}
```

### 3. ClientTabSwitcher

The `ClientTabSwitcher` manages tab content and provides smooth transitions:

- Caches tab content for instant switching
- Shows skeleton loaders during content loading
- Listens for tab change events
- Manages transitions between tabs

```typescript
export function ClientTabSwitcher({ 
  initialContent, 
  currentTab,
  // ... other props
}) {
  // Cache for rendered tab content
  const tabContentRef = useRef<TabContent>({});
  const [clientSideTab, setClientSideTab] = useState<string | null>(null);
  
  // Listen for tab change events
  useEffect(() => {
    const handleTabChange = (event: CustomEvent) => {
      const { tab } = event.detail;
      setClientSideTab(tab);
      setIsLoading(true);
    };
    
    window.addEventListener('tabchange', handleTabChange as EventListener);
    return () => {
      window.removeEventListener('tabchange', handleTabChange as EventListener);
    };
  }, []);
  
  // Determine which content to show (skeleton or actual content)
  const getContent = () => {
    if (clientSideTab && clientSideTab !== activeTab) {
      return <DashboardTabSkeleton type={getTabType()} />;
    }
    
    return isLoading 
      ? <DashboardTabSkeleton type={getTabType()} />
      : tabContentRef.current[activeTab] || initialContent;
  };
  
  return (
    <div>
      {/* Refresh button */}
      <div>...</div>
      
      {/* Content with animations */}
      <AnimatePresence mode="wait">
        <motion.div>
          {getContent()}
        </motion.div>
      </AnimatePresence>
    </div>
  );
}
```

### 4. Server-Side Page Component

The server component provides the initial data and content:

- Fetches initial data on the server
- Renders the initial tab content
- Passes everything to the client components
- Handles authentication and authorization

```typescript
export default async function DashboardPage({ searchParams }) {
  // Get parameters from URL
  const currentTab = searchParams.tab || "overview";
  
  // Fetch user data and check permissions
  const userData = await fetchUserData();
  
  // Generate the initial tab content based on the current tab
  const tabContent = getTabContent(currentTab, userData);
  
  // Render the client-side layout with initial data
  return (
    <ClientDashboardLayout
      initialContent={tabContent}
      currentTab={currentTab}
      // ... pass all necessary data
    />
  );
}
```

## Communication Flow

1. **User clicks a tab in the sidebar**:
   - Sidebar immediately updates its visual state
   - Sidebar dispatches a `tabchange` custom event
   - Sidebar updates the URL using Next.js router

2. **ClientDashboardLayout receives the event**:
   - Updates its active tab state
   - Updates header title and subtitle

3. **ClientTabSwitcher receives the event**:
   - Shows a skeleton loader for the new tab
   - Waits for the new content to load from the server
   - Caches the content for future use

4. **URL is updated**:
   - Next.js router updates the URL without a full page reload
   - Server component re-renders with new data
   - New content is streamed to the client

## Implementation Guidelines

### 1. Component Structure

- **Server Components**: Use for data fetching and initial rendering
- **Client Components**: Use for interactive UI elements and state management
- **Hybrid Approach**: Server-render the initial content, then enhance on the client

### 2. State Management

- Use React's built-in state management for UI state
- Use URL parameters for shareable state
- Use custom events for cross-component communication
- Cache rendered content in refs to avoid unnecessary re-renders

### 3. Performance Optimizations

- Memoize expensive components with `React.memo`
- Use skeleton loaders that match the final UI layout
- Implement progressive loading with Suspense
- Prefetch tab content on hover
- Use `will-change` CSS property for animations

### 4. Accessibility Considerations

- Support keyboard navigation
- Respect reduced motion preferences
- Provide appropriate ARIA attributes
- Ensure proper focus management

## Best Practices

1. **Immediate Feedback**: Always provide immediate visual feedback when a user interacts with the UI
2. **Progressive Enhancement**: Start with a functional server-rendered page, then enhance with client-side features
3. **Skeleton Matching**: Design skeleton loaders that match the final UI to minimize layout shift
4. **Event-Based Communication**: Use custom events for loose coupling between components
5. **URL as Source of Truth**: Maintain URL parameters for deep linking and browser history
6. **Caching Strategy**: Cache rendered content to avoid unnecessary re-renders
7. **Transition Management**: Use smooth transitions between states to improve perceived performance

## Common Patterns

### Skeleton Loading Pattern

```typescript
// Show skeleton during loading
{isLoading ? (
  <DashboardTabSkeleton type={tabType} />
) : (
  <ActualContent data={data} />
)}
```

### Custom Event Communication Pattern

```typescript
// Dispatch event
const event = new CustomEvent('eventName', { 
  detail: { /* data */ } 
});
window.dispatchEvent(event);

// Listen for event
useEffect(() => {
  const handler = (event: CustomEvent) => {
    // Handle event
  };
  
  window.addEventListener('eventName', handler as EventListener);
  return () => {
    window.removeEventListener('eventName', handler as EventListener);
  };
}, []);
```

### Content Caching Pattern

```typescript
// Cache in ref
const contentCache = useRef<Record<string, React.ReactNode>>({});

// Store content
contentCache.current[key] = content;

// Retrieve content
const cachedContent = contentCache.current[key];
```

## Conclusion

This client-side dashboard architecture provides a fast, responsive user experience by maintaining persistent UI elements and providing immediate visual feedback. By following these patterns and guidelines, you can create dashboards that feel like native applications while still leveraging the benefits of server-side rendering for initial data loading.

## Further Reading

- [Next.js App Router Documentation](https://nextjs.org/docs/app)
- [React Server Components](https://nextjs.org/docs/app/building-your-application/rendering/server-components)
- [Custom Events in JavaScript](https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent)
- [Framer Motion Documentation](https://www.framer.com/motion/)
- [React Suspense and Streaming](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming) 