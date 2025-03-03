"use client";

import { ReactNode } from "react";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { Alert, AlertTitle, AlertDescription } from "@/components/ui/alert";
import { AlertCircle } from "lucide-react";

interface ErrorBoundaryProviderProps {
  children: ReactNode;
  componentName?: string;
}

/**
 * ErrorBoundaryProvider Component
 * 
 * A wrapper component that provides error boundary functionality with a default fallback UI.
 * This component can be used to wrap any component or section of the application to catch
 * and handle errors gracefully.
 * 
 * @param children - The components to render
 * @param componentName - Optional name of the component being wrapped (used in the error message)
 */
export function ErrorBoundaryProvider({ 
  children, 
  componentName = "Component" 
}: ErrorBoundaryProviderProps) {
  // Default fallback UI that includes the component name
  const defaultFallback = (
    <Alert variant="destructive" className="my-4">
      <AlertCircle className="h-4 w-4" />
      <AlertTitle>{componentName} Error</AlertTitle>
      <AlertDescription>
        <p className="mb-2">There was an error loading this {componentName.toLowerCase()}.</p>
        <p className="mb-2">Please try refreshing the page or contact support if the issue persists.</p>
      </AlertDescription>
    </Alert>
  );

  return (
    <ErrorBoundary fallback={defaultFallback}>
      {children}
    </ErrorBoundary>
  );
} 