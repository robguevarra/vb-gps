"use client"

import { useState, useEffect } from "react";
import { BulkOnlinePaymentWizard } from "@/components/BulkOnlinePaymentWizard";
import { useToast } from "@/hooks/use-toast";
import { createClient } from "@/utils/supabase/client";
import { AlertCircle } from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";

interface ManualRemittanceTabWrapperProps {
  missionaryId: string;
}

export function ManualRemittanceTabWrapper({ missionaryId }: ManualRemittanceTabWrapperProps) {
  const { toast } = useToast();
  const [missionaryName, setMissionaryName] = useState<string>("");
  
  // Fetch missionary name on component mount
  useEffect(() => {
    const fetchMissionaryName = async () => {
      const supabase = createClient();
      const { data, error } = await supabase
        .from("profiles")
        .select("full_name")
        .eq("id", missionaryId)
        .single();
        
      if (error) {
        console.error("Error fetching missionary name:", error);
        return;
      }
      
      if (data) {
        setMissionaryName(data.full_name);
      }
    };
    
    fetchMissionaryName();
  }, [missionaryId]);

  const handleBulkOnlineSuccess = () => {
    toast({
      title: "Success",
      description: "Payment process initiated successfully",
    });
  };
  
  const handleBulkOnlineError = (error: string) => {
    toast({
      title: "Error",
      description: `Payment process failed: ${error}`,
      variant: "destructive"
    });
  };

  return (
    <div className="flex flex-col gap-6">
      <div className="flex flex-col gap-6 md:flex-row">
        <div className="flex-1 space-y-4">
          <h2 className="text-2xl font-semibold">Bulk Donation Management</h2>
          <p className="text-muted-foreground text-sm">
            Generate a single payment link for multiple donors to streamline your donation collection process.
          </p>
          
          <div className="bg-white p-4 rounded-md shadow dark:bg-gray-800">
            <h3 className="text-lg font-medium">Bulk Online Payment Instructions</h3>
            <p className="text-sm mt-2 text-muted-foreground">
              1. Enter the total amount to be collected.<br />
              2. Add multiple donors with their contribution amounts.<br />
              3. Click "Pay Now" to process the payment directly.<br />
              4. Choose from multiple payment methods including credit/debit cards, e-wallets, bank transfers, and more.
            </p>
          </div>
        </div>
        
        <aside className="w-full md:w-96 lg:w-[30rem]">
          <div className="bg-white dark:bg-gray-800 rounded-md shadow p-4">
            <BulkOnlinePaymentWizard
              missionaryId={missionaryId}
              missionaryName={missionaryName || "Missionary"}
              title="Bulk Online Payment"
              onSuccess={handleBulkOnlineSuccess}
              onError={handleBulkOnlineError}
            />
          </div>
        </aside>
      </div>
    </div>
  );
} 