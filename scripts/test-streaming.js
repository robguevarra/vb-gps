/**
 * Streaming Performance Test Script
 * 
 * This script measures the performance of our streaming implementation by
 * tracking the time between different rendering phases.
 * 
 * Usage:
 * 1. Add the following script tag to your HTML:
 *    <script src="/scripts/test-streaming.js"></script>
 * 2. Add data-streaming-marker attributes to your components:
 *    <div data-streaming-marker="ui-shell">...</div>
 *    <div data-streaming-marker="dashboard-cards">...</div>
 * 3. View the results in the browser console
 * 
 * @file
 */

// Performance markers for streaming components
const STREAMING_MARKERS = [
  'ui-shell',              // UI Shell (layout, header)
  'dashboard-structure',   // Dashboard structure (section headers, containers)
  'dashboard-cards',       // Dashboard cards (metrics)
  'recent-donations',      // Recent donations list
  'charts',                // Charts and visualizations
  'tables'                 // Tables with data
];

// Store the start time when the script loads
const pageStartTime = performance.now();

// Initialize the performance data object
const performanceData = {
  pageLoad: {
    start: pageStartTime,
    end: null,
    duration: null
  },
  components: {}
};

// Initialize component timing objects
STREAMING_MARKERS.forEach(marker => {
  performanceData.components[marker] = {
    start: null,
    end: null,
    duration: null,
    fromPageStart: null
  };
});

// Function to observe DOM changes and detect when streaming components are added
function observeStreamingComponents() {
  // Create a MutationObserver to watch for DOM changes
  const observer = new MutationObserver(mutations => {
    mutations.forEach(mutation => {
      if (mutation.type === 'childList') {
        // Check added nodes for streaming markers
        mutation.addedNodes.forEach(node => {
          if (node.nodeType === Node.ELEMENT_NODE) {
            checkNodeAndChildren(node);
          }
        });
      }
      else if (mutation.type === 'attributes' && 
               mutation.attributeName === 'data-streaming-marker') {
        checkNode(mutation.target);
      }
    });
  });

  // Start observing the document with the configured parameters
  observer.observe(document.body, { 
    childList: true, 
    subtree: true, 
    attributes: true,
    attributeFilter: ['data-streaming-marker']
  });

  // Also check existing elements (in case they were added before the observer was created)
  checkNodeAndChildren(document.body);
}

// Function to check a node and all its children for streaming markers
function checkNodeAndChildren(node) {
  checkNode(node);
  
  // Check all child elements
  const children = node.querySelectorAll('[data-streaming-marker]');
  children.forEach(child => {
    checkNode(child);
  });
}

// Function to check a single node for streaming markers
function checkNode(node) {
  const marker = node.getAttribute('data-streaming-marker');
  
  if (marker && STREAMING_MARKERS.includes(marker)) {
    const now = performance.now();
    const component = performanceData.components[marker];
    
    // Only record the first appearance of each marker
    if (component.start === null) {
      component.start = now;
      component.fromPageStart = now - pageStartTime;
      
      // Log the marker appearance
      console.log(`🔄 Streaming component "${marker}" appeared after ${component.fromPageStart.toFixed(2)}ms`);
      
      // Add a visible indicator to the element (in development only)
      if (process.env.NODE_ENV === 'development') {
        const indicator = document.createElement('div');
        indicator.style.position = 'absolute';
        indicator.style.top = '0';
        indicator.style.right = '0';
        indicator.style.background = 'rgba(0, 255, 0, 0.3)';
        indicator.style.color = 'black';
        indicator.style.padding = '2px 5px';
        indicator.style.fontSize = '10px';
        indicator.style.borderRadius = '3px';
        indicator.style.zIndex = '9999';
        indicator.textContent = `${component.fromPageStart.toFixed(0)}ms`;
        
        // Make sure the element has position relative or absolute
        const position = window.getComputedStyle(node).position;
        if (position === 'static') {
          node.style.position = 'relative';
        }
        
        node.appendChild(indicator);
      }
    }
  }
}

// Function to generate a performance report
function generatePerformanceReport() {
  // Record page load completion
  performanceData.pageLoad.end = performance.now();
  performanceData.pageLoad.duration = performanceData.pageLoad.end - performanceData.pageLoad.start;
  
  // Calculate component durations
  Object.keys(performanceData.components).forEach(marker => {
    const component = performanceData.components[marker];
    if (component.start !== null) {
      // For components that appeared, set the end time to now
      if (component.end === null) {
        component.end = performance.now();
      }
      component.duration = component.end - component.start;
    }
  });
  
  // Log the performance report
  console.log('📊 Streaming Performance Report:');
  console.log(`Total Page Load: ${performanceData.pageLoad.duration.toFixed(2)}ms`);
  console.log('Component Streaming Times:');
  
  // Sort components by appearance time
  const sortedComponents = Object.entries(performanceData.components)
    .filter(([_, data]) => data.start !== null)
    .sort((a, b) => a[1].fromPageStart - b[1].fromPageStart);
  
  // Create a table for the components
  console.table(sortedComponents.map(([marker, data]) => ({
    Component: marker,
    'Time to Appear (ms)': data.fromPageStart.toFixed(2),
    'Duration (ms)': data.duration ? data.duration.toFixed(2) : 'N/A'
  })));
  
  // Calculate streaming efficiency
  if (sortedComponents.length > 0) {
    const firstComponent = sortedComponents[0][1];
    const lastComponent = sortedComponents[sortedComponents.length - 1][1];
    
    const streamingSpan = lastComponent.fromPageStart - firstComponent.fromPageStart;
    const streamingEfficiency = (streamingSpan / performanceData.pageLoad.duration) * 100;
    
    console.log(`Streaming Span: ${streamingSpan.toFixed(2)}ms (${streamingEfficiency.toFixed(2)}% of total load time)`);
  }
  
  // Return the data for potential server logging
  return performanceData;
}

// Start observing when the DOM is ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', observeStreamingComponents);
} else {
  observeStreamingComponents();
}

// Generate the report when the page is fully loaded
window.addEventListener('load', () => {
  // Wait a bit to ensure all streaming components have been detected
  setTimeout(generatePerformanceReport, 1000);
});

// Export the performance data for potential use by other scripts
window.streamingPerformanceData = performanceData;

// Add a global function to manually trigger the performance report
window.generateStreamingReport = generatePerformanceReport; 