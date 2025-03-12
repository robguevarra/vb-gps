# Client-Side Dashboard Code Examples

This document provides practical code examples for implementing the client-side dashboard architecture patterns described in our documentation. These examples demonstrate how to achieve instant feedback, persistent UI elements, and smooth transitions in a Next.js application.

## Table of Contents

1. [Client Dashboard Layout](#client-dashboard-layout)
2. [Persistent Sidebar](#persistent-sidebar)
3. [Client Tab Switcher](#client-tab-switcher)
4. [Custom Event Communication](#custom-event-communication)
5. [Skeleton Loading](#skeleton-loading)
6. [Content Caching](#content-caching)
7. [Page Transitions](#page-transitions)
8. [Performance Optimizations](#performance-optimizations)

## Client Dashboard Layout

The `ClientDashboardLayout` component serves as the container for our client-side dashboard, managing state and coordinating between components:

```tsx
'use client';

import { useState, useEffect, useCallback } from 'react';
import { usePathname, useRouter } from 'next/navigation';
import Sidebar from '@/components/Sidebar';
import ClientTabSwitcher from '@/components/ClientTabSwitcher';

interface ClientDashboardLayoutProps {
  children: React.ReactNode;
  initialTab?: string;
  tabs: { id: string; label: string; icon?: string }[];
  role: string;
}

export default function ClientDashboardLayout({
  children,
  initialTab = 'overview',
  tabs,
  role,
}: ClientDashboardLayoutProps) {
  const router = useRouter();
  const pathname = usePathname();
  const [activeTab, setActiveTab] = useState(initialTab);
  const [isLoading, setIsLoading] = useState(false);
  
  // Extract tab from URL if present
  useEffect(() => {
    const tabFromUrl = pathname.split('/').pop();
    if (tabFromUrl && tabs.some(tab => tab.id === tabFromUrl)) {
      setActiveTab(tabFromUrl);
    }
  }, [pathname, tabs]);
  
  // Listen for tab change events from sidebar
  useEffect(() => {
    const handleTabChange = (event: CustomEvent) => {
      const { tabId, source } = event.detail;
      
      // Only process if this event wasn't triggered by this component
      if (source !== 'layout') {
        setActiveTab(tabId);
        setIsLoading(true);
        
        // Update URL to reflect tab change
        const basePath = pathname.split('/').slice(0, -1).join('/');
        router.push(`${basePath}/${tabId}`);
      }
    };
    
    window.addEventListener('tabchange' as any, handleTabChange);
    return () => window.removeEventListener('tabchange' as any, handleTabChange);
  }, [pathname, router]);
  
  // Handle tab change initiated from this component
  const handleTabChange = useCallback((tabId: string) => {
    setActiveTab(tabId);
    setIsLoading(true);
    
    // Dispatch event to notify other components
    const event = new CustomEvent('tabchange', {
      detail: { tabId, source: 'layout' }
    });
    window.dispatchEvent(event);
    
    // Update URL
    const basePath = pathname.split('/').slice(0, -1).join('/');
    router.push(`${basePath}/${tabId}`);
  }, [pathname, router]);
  
  // Content loaded callback
  const handleContentLoaded = useCallback(() => {
    setIsLoading(false);
  }, []);
  
  return (
    <div className="flex h-screen">
      <Sidebar 
        activeTab={activeTab} 
        tabs={tabs} 
        role={role} 
        onTabChange={handleTabChange} 
      />
      <main className="flex-1 overflow-auto">
        <ClientTabSwitcher
          activeTab={activeTab}
          isLoading={isLoading}
          onContentLoaded={handleContentLoaded}
        >
          {children}
        </ClientTabSwitcher>
      </main>
    </div>
  );
}
```

## Persistent Sidebar

The `Sidebar` component provides navigation and instant visual feedback:

```tsx
'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { motion } from 'framer-motion';
import { 
  Home, 
  Calendar, 
  Users, 
  Settings, 
  FileText, 
  Briefcase 
} from 'lucide-react';

interface SidebarProps {
  activeTab: string;
  tabs: { id: string; label: string; icon?: string }[];
  role: string;
  onTabChange: (tabId: string) => void;
}

export default function Sidebar({ 
  activeTab, 
  tabs, 
  role, 
  onTabChange 
}: SidebarProps) {
  const router = useRouter();
  const [loadingTab, setLoadingTab] = useState<string | null>(null);
  
  // Map of tab IDs to their icon components
  const iconMap: Record<string, React.ReactNode> = {
    overview: <Home size={20} />,
    calendar: <Calendar size={20} />,
    contacts: <Users size={20} />,
    reports: <FileText size={20} />,
    settings: <Settings size={20} />,
    assignments: <Briefcase size={20} />,
  };
  
  // Listen for tab change events from other components
  useEffect(() => {
    const handleTabChange = (event: CustomEvent) => {
      const { tabId, source } = event.detail;
      
      // Only update loading state if event wasn't from this component
      if (source !== 'sidebar') {
        setLoadingTab(tabId);
        
        // Clear loading state after animation completes
        setTimeout(() => {
          setLoadingTab(null);
        }, 300);
      }
    };
    
    window.addEventListener('tabchange' as any, handleTabChange);
    return () => window.removeEventListener('tabchange' as any, handleTabChange);
  }, []);
  
  // Handle tab click
  const handleTabClick = (tabId: string) => {
    // Set loading state immediately for instant feedback
    setLoadingTab(tabId);
    
    // Notify other components about tab change
    const event = new CustomEvent('tabchange', {
      detail: { tabId, source: 'sidebar' }
    });
    window.dispatchEvent(event);
    
    // Call the provided callback
    onTabChange(tabId);
    
    // Clear loading state after animation completes
    setTimeout(() => {
      setLoadingTab(null);
    }, 300);
  };
  
  return (
    <div className="w-64 bg-gray-900 text-white h-full flex flex-col">
      <div className="p-4 border-b border-gray-800">
        <h2 className="text-xl font-bold">Dashboard</h2>
        <p className="text-sm text-gray-400">{role} Portal</p>
      </div>
      
      <nav className="flex-1 p-4">
        <ul className="space-y-2">
          {tabs.map((tab) => {
            const isActive = activeTab === tab.id;
            const isLoading = loadingTab === tab.id;
            
            return (
              <motion.li 
                key={tab.id}
                initial={{ opacity: 0.8 }}
                animate={{ 
                  opacity: 1,
                  scale: isActive ? 1.02 : 1,
                }}
                whileTap={{ scale: 0.98 }}
                transition={{ duration: 0.1 }}
              >
                <button
                  onClick={() => handleTabClick(tab.id)}
                  className={`w-full flex items-center p-3 rounded-lg transition-colors ${
                    isActive 
                      ? 'bg-blue-600 text-white' 
                      : 'text-gray-300 hover:bg-gray-800'
                  }`}
                  aria-current={isActive ? 'page' : undefined}
                >
                  <span className="mr-3">
                    {iconMap[tab.id] || <div className="w-5 h-5" />}
                  </span>
                  <span className="flex-1">{tab.label}</span>
                  
                  {isLoading && (
                    <span className="ml-2 h-4 w-4 rounded-full border-2 border-t-transparent border-white animate-spin" />
                  )}
                </button>
              </motion.li>
            );
          })}
        </ul>
      </nav>
      
      <div className="p-4 border-t border-gray-800">
        <div className="flex items-center">
          <div className="w-8 h-8 rounded-full bg-blue-500 mr-2"></div>
          <div>
            <p className="text-sm font-medium">User Name</p>
            <p className="text-xs text-gray-400">{role}</p>
          </div>
        </div>
      </div>
    </div>
  );
}
```

## Client Tab Switcher

The `ClientTabSwitcher` component manages tab content and transitions:

```tsx
'use client';

import { useState, useEffect, useRef, useCallback } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import DashboardTabSkeleton from './DashboardTabSkeleton';

interface ClientTabSwitcherProps {
  children: React.ReactNode;
  activeTab: string;
  isLoading: boolean;
  onContentLoaded: () => void;
}

export default function ClientTabSwitcher({
  children,
  activeTab,
  isLoading,
  onContentLoaded,
}: ClientTabSwitcherProps) {
  const [content, setContent] = useState<React.ReactNode>(children);
  const [showSkeleton, setShowSkeleton] = useState(false);
  const contentCache = useRef<Record<string, React.ReactNode>>({});
  
  // Cache initial content
  useEffect(() => {
    contentCache.current[activeTab] = children;
    setContent(children);
  }, [children, activeTab]);
  
  // Handle tab changes
  useEffect(() => {
    if (isLoading) {
      // Show skeleton after a short delay to avoid flashing
      const timer = setTimeout(() => {
        setShowSkeleton(true);
      }, 50);
      
      return () => clearTimeout(timer);
    } else {
      setShowSkeleton(false);
      
      // If we have cached content for this tab, use it
      if (contentCache.current[activeTab]) {
        setContent(contentCache.current[activeTab]);
      }
      
      // Notify parent that content is loaded
      onContentLoaded();
    }
  }, [activeTab, isLoading, onContentLoaded]);
  
  // Cache new content when it arrives
  useEffect(() => {
    if (!isLoading && children) {
      contentCache.current[activeTab] = children;
      setContent(children);
    }
  }, [children, activeTab, isLoading]);
  
  return (
    <div className="w-full h-full relative">
      <AnimatePresence mode="wait">
        {showSkeleton ? (
          <motion.div
            key="skeleton"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.2 }}
            className="w-full h-full"
          >
            <DashboardTabSkeleton />
          </motion.div>
        ) : (
          <motion.div
            key="content"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.2 }}
            className="w-full h-full"
          >
            {content}
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}
```

## Custom Event Communication

Example of implementing custom event communication between components:

```tsx
// Event types
interface TabChangeEvent extends CustomEvent {
  detail: {
    tabId: string;
    source: string;
  };
}

// Dispatching an event
function dispatchTabChangeEvent(tabId: string, source: string) {
  const event = new CustomEvent('tabchange', {
    detail: { tabId, source }
  });
  window.dispatchEvent(event);
}

// Listening for events
useEffect(() => {
  const handleTabChange = (event: TabChangeEvent) => {
    const { tabId, source } = event.detail;
    // Handle the event...
  };
  
  window.addEventListener('tabchange', handleTabChange as EventListener);
  return () => window.removeEventListener('tabchange', handleTabChange as EventListener);
}, []);
```

## Skeleton Loading

Example of a skeleton loader component that matches the final UI:

```tsx
'use client';

import { motion } from 'framer-motion';

export default function DashboardTabSkeleton() {
  return (
    <div className="p-6 space-y-6 w-full">
      {/* Header skeleton */}
      <div className="flex justify-between items-center">
        <div className="space-y-2">
          <motion.div 
            className="h-8 w-48 bg-gray-200 rounded-md"
            animate={{ opacity: [0.5, 0.8, 0.5] }}
            transition={{ duration: 1.5, repeat: Infinity }}
          />
          <motion.div 
            className="h-4 w-64 bg-gray-200 rounded-md"
            animate={{ opacity: [0.5, 0.7, 0.5] }}
            transition={{ duration: 1.5, repeat: Infinity, delay: 0.2 }}
          />
        </div>
        <motion.div 
          className="h-10 w-24 bg-gray-200 rounded-md"
          animate={{ opacity: [0.5, 0.7, 0.5] }}
          transition={{ duration: 1.5, repeat: Infinity }}
        />
      </div>
      
      {/* Content skeleton */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {Array.from({ length: 6 }).map((_, i) => (
          <motion.div 
            key={i}
            className="h-48 bg-gray-200 rounded-lg p-4"
            animate={{ opacity: [0.5, 0.7, 0.5] }}
            transition={{ 
              duration: 1.5, 
              repeat: Infinity, 
              delay: i * 0.1 
            }}
          >
            <div className="space-y-4">
              <motion.div 
                className="h-6 w-3/4 bg-gray-300 rounded-md"
                animate={{ opacity: [0.5, 0.8, 0.5] }}
                transition={{ duration: 1.5, repeat: Infinity }}
              />
              <motion.div 
                className="h-4 w-full bg-gray-300 rounded-md"
                animate={{ opacity: [0.5, 0.7, 0.5] }}
                transition={{ duration: 1.5, repeat: Infinity, delay: 0.2 }}
              />
              <motion.div 
                className="h-4 w-2/3 bg-gray-300 rounded-md"
                animate={{ opacity: [0.5, 0.7, 0.5] }}
                transition={{ duration: 1.5, repeat: Infinity, delay: 0.4 }}
              />
            </div>
          </motion.div>
        ))}
      </div>
    </div>
  );
}
```

## Content Caching

Example of implementing content caching for instant tab switching:

```tsx
'use client';

import { useRef, useState, useEffect } from 'react';

interface ContentCacheProps {
  cacheKey: string;
  children: React.ReactNode;
}

export function ContentCache({ cacheKey, children }: ContentCacheProps) {
  const [content, setContent] = useState<React.ReactNode>(children);
  const cache = useRef<Record<string, React.ReactNode>>({});
  
  // Update cache when children change
  useEffect(() => {
    cache.current[cacheKey] = children;
    setContent(children);
  }, [children, cacheKey]);
  
  // Retrieve from cache when key changes
  useEffect(() => {
    if (cache.current[cacheKey]) {
      setContent(cache.current[cacheKey]);
    }
  }, [cacheKey]);
  
  return <>{content}</>;
}

// Usage example
function MyComponent() {
  const [activeTab, setActiveTab] = useState('tab1');
  
  return (
    <div>
      <button onClick={() => setActiveTab('tab1')}>Tab 1</button>
      <button onClick={() => setActiveTab('tab2')}>Tab 2</button>
      
      <ContentCache cacheKey={activeTab}>
        {activeTab === 'tab1' && <Tab1Content />}
        {activeTab === 'tab2' && <Tab2Content />}
      </ContentCache>
    </div>
  );
}
```

## Page Transitions

Example of smooth page transitions using Framer Motion:

```tsx
'use client';

import { motion, AnimatePresence } from 'framer-motion';

interface PageTransitionProps {
  children: React.ReactNode;
  isVisible: boolean;
}

export default function PageTransition({ 
  children, 
  isVisible 
}: PageTransitionProps) {
  return (
    <AnimatePresence mode="wait">
      {isVisible && (
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          exit={{ opacity: 0, y: -10 }}
          transition={{ 
            duration: 0.3,
            ease: [0.25, 0.1, 0.25, 1.0] 
          }}
          style={{ 
            width: '100%', 
            height: '100%',
            willChange: 'opacity, transform' 
          }}
        >
          {children}
        </motion.div>
      )}
    </AnimatePresence>
  );
}

// Usage example
function TabContent({ activeTab }: { activeTab: string }) {
  return (
    <div className="relative w-full h-full">
      <PageTransition isVisible={activeTab === 'tab1'}>
        <div>Tab 1 Content</div>
      </PageTransition>
      
      <PageTransition isVisible={activeTab === 'tab2'}>
        <div>Tab 2 Content</div>
      </PageTransition>
    </div>
  );
}
```

## Performance Optimizations

Examples of performance optimizations for smooth interactions:

```tsx
'use client';

import { memo, useCallback, useMemo } from 'react';

// 1. Component memoization
const MemoizedComponent = memo(function ExpensiveComponent({ data }: { data: any[] }) {
  return (
    <div>
      {data.map(item => (
        <div key={item.id}>{item.name}</div>
      ))}
    </div>
  );
});

// 2. Callback memoization
function ParentComponent() {
  const handleClick = useCallback(() => {
    // Handle click event
  }, []);
  
  return <ChildComponent onClick={handleClick} />;
}

// 3. Data memoization
function DataProcessor({ rawData }: { rawData: any[] }) {
  const processedData = useMemo(() => {
    return rawData.map(item => ({
      ...item,
      processed: true,
      displayName: `${item.firstName} ${item.lastName}`
    }));
  }, [rawData]);
  
  return <DataDisplay data={processedData} />;
}

// 4. CSS optimizations
function AnimatedComponent() {
  return (
    <div 
      className="transition-transform duration-300 ease-out"
      style={{ 
        willChange: 'transform',
        transform: 'translateZ(0)' // Hardware acceleration
      }}
    >
      Animated content
    </div>
  );
}

// 5. Virtualized lists for large datasets
import { useVirtualizer } from '@tanstack/react-virtual';

function VirtualizedList({ items }: { items: any[] }) {
  const parentRef = useRef<HTMLDivElement>(null);
  
  const virtualizer = useVirtualizer({
    count: items.length,
    getScrollElement: () => parentRef.current,
    estimateSize: () => 50,
  });
  
  return (
    <div 
      ref={parentRef} 
      className="h-[500px] overflow-auto"
    >
      <div
        style={{
          height: `${virtualizer.getTotalSize()}px`,
          width: '100%',
          position: 'relative',
        }}
      >
        {virtualizer.getVirtualItems().map(virtualItem => (
          <div
            key={virtualItem.key}
            style={{
              position: 'absolute',
              top: 0,
              left: 0,
              width: '100%',
              height: `${virtualItem.size}px`,
              transform: `translateY(${virtualItem.start}px)`,
            }}
          >
            {items[virtualItem.index].name}
          </div>
        ))}
      </div>
    </div>
  );
}
```

These code examples demonstrate the key patterns and techniques used in our client-side dashboard architecture. By following these patterns, you can create responsive, app-like experiences with instant feedback and smooth transitions. 