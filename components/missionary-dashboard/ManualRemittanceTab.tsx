"use client"

import { ManualRemittanceWizard } from "@/components/ManualRemittanceWizard";
import { useToast } from "@/hooks/use-toast";

interface ManualRemittanceTabWrapperProps {
  missionaryId: string;
}

export function ManualRemittanceTabWrapper({ missionaryId }: ManualRemittanceTabWrapperProps) {
  const { toast } = useToast();

  const handleSuccess = () => {
    // Additional success handling if needed beyond what's in the component
    console.log("Remittance successfully recorded");
  };

  const handleError = (error: string) => {
    // Additional error handling if needed beyond what's in the component
    console.error("Remittance error:", error);
  };

  return (
    <div className="flex flex-col gap-6 md:flex-row">
      <div className="flex-1 space-y-4">
        <h2 className="text-2xl font-semibold">Manual Remittance</h2>
        <p className="text-muted-foreground text-sm">
          Here you can record offline donations. Enter the total amount, add partners, and submit.
        </p>
        <div className="bg-white p-4 rounded-md shadow dark:bg-gray-800">
          <h3 className="text-lg font-medium">Remittance Instructions</h3>
          <p className="text-sm mt-2 text-muted-foreground">
            1. Fill out the total amount received.<br />
            2. Add each partner entry and the amount they contributed.<br />
            3. Click Submit to record these donations.
          </p>
        </div>
      </div>
      <aside className="w-full md:w-96 lg:w-[30rem] bg-white dark:bg-gray-800 rounded-md shadow p-4">
        <ManualRemittanceWizard
          userId={missionaryId}
          title="Manual Remittance"
          onSuccess={handleSuccess}
          onError={handleError}
        />
      </aside>
    </div>
  );
} 