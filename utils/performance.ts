/**
 * Performance Monitoring Utilities
 * 
 * A collection of utility functions for tracking and measuring component performance.
 * These utilities help identify performance bottlenecks and measure optimization improvements.
 */

/**
 * Tracks the render time of a component
 * 
 * Use this in useEffect with an empty dependency array to measure initial render time,
 * or with dependencies to measure re-render time when those dependencies change.
 * 
 * @example
 * // In a component:
 * useEffect(() => {
 *   const endTracking = trackPerformance('MyComponent');
 *   return endTracking;
 * }, []);
 * 
 * @param componentName - The name of the component being tracked
 * @returns A cleanup function that logs the render time when called
 */
export function trackPerformance(componentName: string) {
  if (typeof window === 'undefined') return () => {};
  
  const startTime = performance.now();
  
  return () => {
    const endTime = performance.now();
    const duration = endTime - startTime;
    
    // Log performance data
    console.log(`[Performance] ${componentName} render time: ${duration.toFixed(2)}ms`);
    
    // Could send to analytics service in production
    // analytics.trackPerformance(componentName, duration);
  };
}

/**
 * Creates a performance marker for measuring specific operations
 * 
 * @example
 * // In a component or function:
 * const marker = createPerformanceMarker('DataProcessing');
 * // ... do some work ...
 * marker.end(); // Logs the time taken
 * 
 * @param operationName - The name of the operation being measured
 * @returns An object with an end method to complete the measurement
 */
export function createPerformanceMarker(operationName: string) {
  if (typeof window === 'undefined') return { end: () => {} };
  
  const startTime = performance.now();
  
  return {
    end: () => {
      const endTime = performance.now();
      const duration = endTime - startTime;
      
      console.log(`[Performance] ${operationName} took ${duration.toFixed(2)}ms`);
      
      return duration;
    }
  };
}

/**
 * Measures the execution time of a function
 * 
 * @example
 * // Wrap a function to measure its execution time:
 * const result = measureExecutionTime(() => {
 *   // ... expensive operation ...
 *   return someValue;
 * }, 'ExpensiveCalculation');
 * 
 * @param fn - The function to measure
 * @param operationName - The name of the operation for logging
 * @returns The result of the function
 */
export function measureExecutionTime<T>(fn: () => T, operationName: string): T {
  if (typeof window === 'undefined') return fn();
  
  const startTime = performance.now();
  const result = fn();
  const endTime = performance.now();
  const duration = endTime - startTime;
  
  console.log(`[Performance] ${operationName} execution time: ${duration.toFixed(2)}ms`);
  
  return result;
}

/**
 * Creates a debounced function that delays invoking the provided function
 * until after the specified wait time has elapsed since the last invocation.
 * 
 * @example
 * // Create a debounced function:
 * const debouncedSearch = debounce((searchTerm) => {
 *   // Perform search operation
 * }, 300);
 * 
 * // Call it multiple times, but it will only execute once after the delay:
 * debouncedSearch('test');
 * debouncedSearch('test2'); // Cancels the previous call
 * 
 * @param fn - The function to debounce
 * @param wait - The number of milliseconds to delay
 * @returns A debounced version of the function
 */
export function debounce<T extends (...args: any[]) => any>(
  fn: T,
  wait: number
): (...args: Parameters<T>) => void {
  let timeout: NodeJS.Timeout | null = null;
  
  return function(...args: Parameters<T>) {
    if (timeout) {
      clearTimeout(timeout);
    }
    
    timeout = setTimeout(() => {
      fn(...args);
    }, wait);
  };
} 