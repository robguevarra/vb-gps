# Lead Pastor Dashboard UI/UX Design Document

## Overview

This design document serves as a comprehensive blueprint for the Lead Pastor Dashboard, detailing the UI/UX principles, implementation strategies, and responsive design patterns used throughout the application. The dashboard is designed to provide lead pastors with tools to manage staff approvals, view reports, and monitor missionary performance across their churches.

## Design Philosophy

The Lead Pastor Dashboard follows these core design principles:

1. **Mobile-First Approach**: All components are designed with mobile users in mind first, then enhanced for larger screens.
2. **Consistent Visual Language**: Uniform styling, spacing, and interaction patterns across all components.
3. **Accessibility**: Ensuring all elements are accessible to users with disabilities.
4. **Progressive Enhancement**: Core functionality works on all devices, with enhanced experiences on more capable devices.
5. **Performance Optimization**: Minimizing unnecessary renders and optimizing for speed.

## Color System

The application uses a semantic color system with these key variables:

- **Primary**: Used for primary actions and key indicators
- **Secondary**: Used for secondary actions and supporting elements
- **Accent**: Used for highlighting active states and important UI elements
- **Muted**: Used for subtle backgrounds and less important text
- **Background**: Main background color
- **Foreground**: Main text color
- **Destructive**: Used for errors, warnings, and destructive actions

Status colors follow a consistent pattern:
- **Green (≥80%)**: Good performance
- **Yellow (60-79%)**: Moderate performance
- **Orange (40-59%)**: Needs improvement
- **Red (<40%)**: Critical attention needed

## Typography

The typography system uses a hierarchical scale:
- **Headings**: Bold, larger sizes (text-lg to text-3xl)
- **Body Text**: Regular weight, readable size (text-sm to text-base)
- **Supporting Text**: Lighter weight, smaller size (text-xs to text-sm)

## Spacing System

Spacing follows a consistent pattern using Tailwind's scale:
- **Micro Spacing**: p-1, m-1, gap-1 (0.25rem)
- **Small Spacing**: p-2, m-2, gap-2 (0.5rem)
- **Medium Spacing**: p-4, m-4, gap-4 (1rem)
- **Large Spacing**: p-6, m-6, gap-6 (1.5rem)
- **Extra Large Spacing**: p-8, m-8, gap-8 (2rem)

## Component Documentation

### 1. LeadPastorSidebar Component

The LeadPastorSidebar serves as the primary navigation for the dashboard, implemented with both mobile and desktop variants.

#### Mobile Implementation

```typescript
<Sheet>
  <SheetTrigger asChild>
    <Button 
      variant="outline" 
      size="icon" 
      className="lg:hidden fixed bottom-4 right-4 z-50 h-12 w-12 rounded-full shadow-lg border-2"
    >
      <Menu className="h-5 w-5" />
      <span className="sr-only">Toggle navigation</span>
    </Button>
  </SheetTrigger>
  <SheetContent side="left" className="w-[85vw] sm:w-80 p-0">
    {/* Content */}
  </SheetContent>
</Sheet>
```

**Key Design Decisions:**

1. **Floating Action Button (FAB)**:
   - Positioned in the bottom-right corner for easy thumb access on mobile
   - Large touch target (h-12 w-12) exceeding the minimum 44×44px recommendation
   - Rounded shape (rounded-full) for visual distinction
   - Shadow and border to create depth and improve visibility
   - Fixed position to ensure accessibility regardless of scroll position
   - Z-index (z-50) to ensure it appears above other content

2. **Slide-Out Sheet**:
   - Responsive width (85% on smallest screens, 80px on small screens)
   - Zero padding at the container level (p-0) to allow for more precise internal spacing
   - Left-side positioning for conventional navigation patterns

3. **Navigation Items**:
   - Large touch targets (px-4 py-3) exceeding minimum recommendations
   - Visual separation between items (my-1)
   - Clear active state indicators (background color, font weight, chevron icon)
   - Truncation for text overflow prevention
   - Descriptive secondary text to provide context
   - Consistent spacing (gap-3) between icon and text

#### Desktop Implementation

```typescript
<div className="hidden lg:block fixed left-0 top-16 bottom-0 w-64 border-r bg-background">
  <div className="p-4 border-b">
    <h3 className="text-lg font-semibold">Pastor Dashboard</h3>
  </div>
  <ScrollArea className="h-[calc(100vh-8rem)]">
    <nav className="p-3 space-y-1">
      {/* Navigation Items */}
    </nav>
  </ScrollArea>
</div>
```

**Key Design Decisions:**

1. **Persistent Sidebar**:
   - Fixed positioning for constant visibility
   - Width of 16rem (w-64) provides adequate space without consuming too much screen real estate
   - Border separation for visual distinction
   - Hidden on mobile (hidden lg:block) to avoid duplicate navigation

2. **Scrollable Navigation**:
   - ScrollArea component with calculated height to ensure it fits within viewport
   - Consistent padding (p-3) for visual comfort
   - Vertical spacing between items (space-y-1) for clear separation

3. **Visual Hierarchy**:
   - Distinct header with border separation
   - Consistent styling with mobile version for unified experience
   - Simplified item display (no descriptions) to optimize for space

### 2. MissionariesTable Component

The MissionariesTable component displays missionary performance data in both card and table formats, adapting to different screen sizes.

#### Mobile Card View

```typescript
<div className="md:hidden space-y-4">
  {pageData.map((m) => (
    <Card key={m.id} className="overflow-hidden">
      <CardContent className="p-4 space-y-4">
        {/* Card content */}
      </CardContent>
    </Card>
  ))}
</div>
```

**Key Design Decisions:**

1. **Card-Based Layout**:
   - Stacked cards (space-y-4) for vertical scrolling on mobile
   - Visible only on small screens (md:hidden)
   - Overflow hidden to maintain clean edges
   - Adequate padding (p-4) for content breathing room
   - Vertical spacing between content sections (space-y-4)

2. **Information Hierarchy**:
   - Name and role prominently displayed at top
   - Performance percentage as a badge for immediate visibility
   - Key metrics (monthly goal, progress) in a structured format
   - Action buttons at the bottom with equal prominence (flex-1)

3. **Visual Progress Indicators**:
   - Color-coded progress bars that adapt based on performance level
   - Matching text colors for reinforcement
   - Animated transitions (transition-all duration-500) for engaging feedback
   - Percentage displayed as a badge with semantic coloring

#### Desktop Table View

```typescript
<div className="hidden md:block">
  <Card className="overflow-hidden border shadow-sm">
    <div className="overflow-x-auto">
      <table className="w-full text-sm">
        {/* Table content */}
      </table>
    </div>
  </Card>
</div>
```

**Key Design Decisions:**

1. **Responsive Table**:
   - Visible only on medium screens and up (hidden md:block)
   - Horizontal scrolling (overflow-x-auto) for tables that exceed viewport width
   - Contained within a card for consistent styling
   - Reduced text size (text-sm) to accommodate more data

2. **Table Structure**:
   - Semantic HTML (thead, tbody, tr, td) for accessibility
   - Consistent column widths for alignment
   - Hover states (hover:bg-muted/30) for row identification
   - Border separation between rows for clarity

3. **Action Buttons**:
   - Tooltips for additional context
   - Compact sizing (size="sm") to fit within table cells
   - Consistent iconography with mobile view

#### Pagination Controls

```typescript
<div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
  <p className="text-sm text-muted-foreground order-2 sm:order-1">
    {/* Pagination text */}
  </p>
  <div className="flex items-center justify-center gap-1 order-1 sm:order-2">
    {/* Pagination controls */}
  </div>
</div>
```

**Key Design Decisions:**

1. **Responsive Layout**:
   - Stack vertically on mobile (flex-col)
   - Horizontal alignment on larger screens (sm:flex-row)
   - Reordering elements based on screen size (order-1, order-2)
   - Consistent spacing (gap-4) between elements

2. **Mobile Optimization**:
   - Simplified pagination on mobile (current/total pages)
   - Expanded pagination on desktop (page numbers)
   - Consistent button sizing (h-8 w-8) for touch targets

### 3. ChurchReportsTab Component

The ChurchReportsTab component provides an overview of missionary performance with summary metrics and detailed reports.

#### Summary Metrics Section

```typescript
<div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-4">
  <div className="bg-muted/50 p-4 rounded-lg">
    {/* Metric content */}
  </div>
  {/* Additional metrics */}
</div>
```

**Key Design Decisions:**

1. **Responsive Grid**:
   - Single column on mobile (grid-cols-1)
   - Two columns on small screens (sm:grid-cols-2)
   - Four columns on medium screens and up (md:grid-cols-4)
   - Consistent spacing between items (gap-4)

2. **Metric Cards**:
   - Subtle background (bg-muted/50) for visual distinction
   - Consistent padding (p-4) and rounded corners (rounded-lg)
   - Icon + label pattern for clear identification
   - Large, bold numbers for emphasis
   - Supporting badges for additional context

#### Tabbed Interface

```typescript
<Tabs defaultValue="missionaries" className="space-y-4">
  <TabsList className="w-full sm:w-auto flex">
    <TabsTrigger value="missionaries" className="flex-1 sm:flex-initial">
      Missionary Performance
    </TabsTrigger>
    <TabsTrigger value="trends" className="flex-1 sm:flex-initial">
      Trends & Analysis
    </TabsTrigger>
  </TabsList>
  
  <TabsContent value="missionaries" className="space-y-4">
    {/* Content */}
  </TabsContent>
  
  <TabsContent value="trends" className="space-y-4">
    {/* Content */}
  </TabsContent>
</Tabs>
```

**Key Design Decisions:**

1. **Responsive Tabs**:
   - Full-width tabs on mobile (w-full, flex-1)
   - Auto-width tabs on larger screens (sm:w-auto, sm:flex-initial)
   - Consistent vertical spacing (space-y-4) between tab list and content
   - Flex layout for equal distribution on mobile

2. **Loading States**:
   - Custom Skeleton component for consistent loading indicators
   - Maintains layout structure during loading
   - Animated pulse effect for visual feedback

### 4. MissionaryModals Component

The MissionaryModals component provides detailed performance data in modal dialogs.

#### Modal Design

```typescript
<DialogContent className="w-[95vw] sm:w-auto max-w-4xl max-h-[90vh] overflow-hidden flex flex-col p-0">
  <DialogHeader className="px-4 py-3 border-b">
    {/* Header content */}
  </DialogHeader>
  <ScrollArea className="flex-1 overflow-auto">
    {/* Modal content */}
  </ScrollArea>
  <div className="p-4 border-t flex justify-end">
    {/* Footer content */}
  </div>
</DialogContent>
```

**Key Design Decisions:**

1. **Responsive Sizing**:
   - Nearly full-width on mobile (w-[95vw])
   - Auto width with maximum constraints on larger screens (sm:w-auto max-w-4xl)
   - Height constraint (max-h-[90vh]) to prevent overflow
   - Zero base padding (p-0) for precise internal spacing control

2. **Modal Structure**:
   - Clear header with border separation
   - Scrollable content area that flexibly expands (flex-1)
   - Fixed footer with action buttons
   - Flex column layout for proper structure

3. **Mobile Considerations**:
   - Close button in header for easy dismissal
   - Scrollable content to accommodate limited screen space
   - Simplified data presentation on smaller screens

### 5. LeadPastorApprovalTab Component

The LeadPastorApprovalTab component provides an interface for lead pastors to review and approve requests.

#### Tabbed Navigation

```typescript
<Tabs value={activeRequestType} onValueChange={(v) => {
  setActiveRequestType(v as 'leave' | 'surplus')
  setCurrentPage(1)
}}>
  <TabsList className="h-9">
    <TabsTrigger value="leave" className="flex gap-1 px-3 text-sm">
      <Calendar className="h-4 w-4" /> 
      Leaves
    </TabsTrigger>
    <TabsTrigger value="surplus" className="flex gap-1 px-3 text-sm">
      <Wallet className="h-4 w-4" /> 
      Surplus
    </TabsTrigger>
  </TabsList>
</Tabs>
```

**Key Design Decisions:**

1. **Compact Tabs**:
   - Fixed height (h-9) for consistent sizing
   - Icon + text pattern for visual recognition
   - Adequate padding (px-3) for touch targets
   - Small text (text-sm) to fit more content

2. **Interactive Behavior**:
   - State reset on tab change (setCurrentPage(1))
   - Consistent spacing between icon and text (gap-1)
   - Visual feedback for active state

#### Search and Filter Controls

```typescript
<div className="flex gap-1 items-center">
  <Input 
    placeholder="Search..." 
    className="max-w-[180px] h-7 text-xs"
    value={searchQuery}
    onChange={(e) => {
      setSearchQuery(e.target.value)
      setCurrentPage(1)
    }}
  />
  <Button variant="outline" size="sm" className="h-7">
    <Filter className="h-3 w-3" />
  </Button>
</div>
```

**Key Design Decisions:**

1. **Compact Controls**:
   - Limited width for search input (max-w-[180px])
   - Small height (h-7) to save vertical space
   - Small text (text-xs) for compact appearance
   - Icon-only filter button for space efficiency

2. **Responsive Behavior**:
   - Flex layout for alignment
   - Small gap (gap-1) between elements
   - State reset on search (setCurrentPage(1))

## Responsive Design Strategy

The application follows these responsive breakpoints:

1. **Base (Mobile First)**: All styles are designed for mobile first
2. **sm**: 640px and up - Small tablets and large phones
3. **md**: 768px and up - Tablets and small laptops
4. **lg**: 1024px and up - Laptops and desktops
5. **xl**: 1280px and up - Large desktops

### Key Responsive Patterns

1. **Layout Shifting**:
   - Grid columns increase with screen size: `grid-cols-1 sm:grid-cols-2 md:grid-cols-4`
   - Flex direction changes: `flex-col sm:flex-row`
   - Element reordering: `order-2 sm:order-1`

2. **Component Swapping**:
   - Cards on mobile, tables on desktop: `md:hidden` and `hidden md:block`
   - Simplified controls on mobile, expanded on desktop

3. **Element Sizing**:
   - Percentage-based widths on mobile: `w-[85vw]`
   - Fixed widths on desktop: `sm:w-80`
   - Calculated heights: `h-[calc(100vh-5rem)]`

4. **Touch Optimization**:
   - Larger touch targets on mobile
   - More spacing between interactive elements
   - Floating action buttons for key actions

## Accessibility Considerations

1. **Semantic HTML**:
   - Proper heading hierarchy (h1, h2, h3)
   - Semantic table structure (thead, tbody)
   - Appropriate button and link usage

2. **Screen Reader Support**:
   - SR-only text for icon-only buttons
   - Descriptive aria labels
   - Proper focus management

3. **Keyboard Navigation**:
   - Focusable elements in logical order
   - Visible focus states
   - Keyboard-accessible modals and dropdowns

4. **Color Contrast**:
   - Sufficient contrast ratios for text
   - Non-color-dependent status indicators
   - Alternative visual cues (icons, shapes)

## Performance Optimizations

1. **Efficient Rendering**:
   - Memoized calculations: `useMemo` for filtered data
   - Pagination to limit rendered items
   - Conditional rendering for complex components

2. **Asset Optimization**:
   - SVG icons for crisp rendering at any size
   - Lazy loading for modals and off-screen content
   - Skeleton loaders for perceived performance

3. **State Management**:
   - Local state for UI interactions
   - Debounced search inputs
   - Optimized re-renders

## Implementation Guidelines

When implementing new features or components for the Lead Pastor Dashboard, developers should:

1. **Follow Mobile-First Approach**:
   - Start with mobile layout and progressively enhance
   - Test on multiple device sizes
   - Use responsive utility classes consistently

2. **Maintain Visual Consistency**:
   - Use the established color system
   - Follow typography and spacing patterns
   - Reuse existing components when possible

3. **Ensure Accessibility**:
   - Test with screen readers
   - Verify keyboard navigation
   - Maintain sufficient color contrast

4. **Optimize Performance**:
   - Minimize unnecessary renders
   - Use pagination for large data sets
   - Implement loading states for async operations

5. **Document New Components**:
   - Add JSDoc comments for component props
   - Document key design decisions
   - Update this design document with significant changes

## Mobile-Friendly Best Practices

1. **Touch Targets**:
   - Minimum size of 44×44 pixels for all interactive elements
   - Adequate spacing between touch targets (minimum 8px)
   - Larger buttons for primary actions

2. **Viewport Considerations**:
   - Proper meta viewport tag: `<meta name="viewport" content="width=device-width, initial-scale=1.0">`
   - No horizontal scrolling on mobile
   - Content fits within viewport width

3. **Text Readability**:
   - Minimum font size of 16px for body text
   - High contrast for text elements
   - Adequate line height (1.5) for readability

4. **Navigation Patterns**:
   - Hamburger menu or bottom navigation for mobile
   - Persistent navigation for desktop
   - Clear visual indicators for current location

5. **Form Elements**:
   - Stacked form layouts on mobile
   - Full-width inputs for easier interaction
   - Native input types for appropriate keyboard

6. **Content Prioritization**:
   - Most important content first on mobile
   - Progressive disclosure for secondary information
   - Collapsible sections for dense content

## Conclusion

This design document serves as the definitive guide for UI/UX implementation in the Lead Pastor Dashboard. By following these guidelines, we ensure a consistent, accessible, and performant experience across all devices and screen sizes. The mobile-first approach with progressive enhancement guarantees that all users receive an optimal experience tailored to their device capabilities. 