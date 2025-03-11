"use client";

import { Suspense, useEffect } from "react";
import dynamic from "next/dynamic";
import { LineChartSkeleton } from "./LineChartSkeleton";
import { ErrorBoundary } from "react-error-boundary";
import { trackPerformance } from "@/utils/performance";

// Define the props interface
interface LineChartProps {
  data: Array<{
    x: string;
    y: number;
  }>;
  goal?: number;
}

// Dynamically import the LineChart component
const LineChart = dynamic(
  () => import("./LineChart"),
  {
    loading: () => <LineChartSkeleton />,
    ssr: false,
  }
);

// Preload function for the LineChart
const preloadLineChart = () => {
  // This will start loading the component in the background
  import("./LineChart");
};

/**
 * LineChartWrapper Component
 * 
 * A wrapper component that lazy loads the LineChart component
 * and provides error boundary protection. Implements optimized code splitting,
 * preloading, and performance tracking.
 * 
 * @param data - Array of data points to plot
 * @param goal - Optional goal line value
 */
export function LineChartWrapper({ data, goal }: LineChartProps) {
  // Track component performance
  useEffect(() => {
    const endTracking = trackPerformance('LineChartWrapper');
    return endTracking;
  }, []);

  // Preload the chart component when this wrapper mounts
  useEffect(() => {
    preloadLineChart();
  }, []);

  const handleError = (error: Error) => {
    console.error('Chart error:', error);
  };

  return (
    <ErrorBoundary 
      fallback={
        <div className="p-4 text-red-500 border border-red-200 rounded-md">
          There was an error loading the chart. Please try again or contact support.
        </div>
      }
      onError={handleError}
    >
      <Suspense fallback={<LineChartSkeleton />}>
        <LineChart 
          data={data}
          goal={goal}
        />
      </Suspense>
    </ErrorBoundary>
  );
}