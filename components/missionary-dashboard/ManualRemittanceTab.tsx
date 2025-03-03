import { Suspense } from "react";
import { createClient } from "@/utils/supabase/server";
import { ManualRemittanceTabClient } from "@/components/missionary-dashboard/ManualRemittanceTabClient";
import { PaymentWizardSkeleton } from "@/components/missionary-dashboard/PaymentWizardSkeleton";
import { ErrorBoundaryProvider } from "@/components/ErrorBoundaryProvider";

interface ManualRemittanceTabProps {
  missionaryId: string;
  missionaryName: string;
  initialError?: string;
}

interface ManualRemittanceTabWrapperProps {
  missionaryId: string;
}

/**
 * ManualRemittanceTabWrapper Component
 * 
 * Server component wrapper that fetches missionary data and passes it to the ManualRemittanceTab.
 * This is the main entry point used by the dashboard page.
 * 
 * @param missionaryId - The ID of the missionary to fetch data for
 */
export async function ManualRemittanceTabWrapper({ 
  missionaryId 
}: ManualRemittanceTabWrapperProps) {
  const supabase = await createClient();
  
  // Fetch missionary data on the server
  const { data: missionary, error } = await supabase
    .from("profiles")
    .select("id, full_name")
    .eq("id", missionaryId)
    .single();
    
  if (error) {
    console.error("Error fetching missionary data:", error);
    // Return ManualRemittanceTab with error state
    return (
      <ManualRemittanceTab 
        missionaryId={missionaryId} 
        missionaryName="Missionary"
        initialError="Failed to load missionary data"
      />
    );
  }
  
  return (
    <ManualRemittanceTab 
      missionaryId={missionary.id} 
      missionaryName={missionary.full_name || "Missionary"}
    />
  );
}

/**
 * ManualRemittanceTab Component
 * 
 * Server component that handles the rendering of the manual remittance tab.
 * Implements optimized data fetching and proper error handling.
 * 
 * @param missionaryId - The ID of the missionary
 * @param missionaryName - The name of the missionary
 * @param initialError - Optional initial error message
 */
export async function ManualRemittanceTab({ 
  missionaryId, 
  missionaryName,
  initialError
}: ManualRemittanceTabProps) {
  return (
    <ErrorBoundaryProvider componentName="Manual Remittance Tab">
      <Suspense fallback={<PaymentWizardSkeleton />}>
        <ManualRemittanceTabClient 
          missionaryId={missionaryId} 
          missionaryName={missionaryName}
          initialError={initialError}
        />
      </Suspense>
    </ErrorBoundaryProvider>
  );
} 