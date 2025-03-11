"use client";

import { useEffect, useState } from "react";
import { OnlinePaymentWizard } from "@/components/OnlinePaymentWizard";
import { createClient } from "@/utils/supabase/client";
import { useRouter } from "next/navigation";
import { Card, CardContent } from "@/components/ui/card";
import { Loader2, AlertCircle } from "lucide-react";

export default function GeneratePaymentPage() {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [profile, setProfile] = useState<any>(null);
  const router = useRouter();
  const supabase = createClient();

  // Fetch the current user's profile
  useEffect(() => {
    async function fetchUserProfile() {
      try {
        // Check user session
        const { data: { session }, error: sessionError } = await supabase.auth.getSession();
        
        if (sessionError || !session) {
          throw new Error("You must be logged in to access this page");
        }

        // Get user profile
        const { data: profile, error: profileError } = await supabase
          .from("profiles")
          .select("id, full_name, role")
          .eq("id", session.user.id)
          .single();
          
        if (profileError || !profile) {
          throw new Error("Could not load your profile");
        }
        
        // Check if user is a missionary
        if (profile.role !== "missionary") {
          throw new Error("Only missionaries can generate payment links");
        }
        
        setProfile(profile);
      } catch (error) {
        setError(error instanceof Error ? error.message : "An error occurred");
        // Redirect non-missionaries after a delay
        setTimeout(() => {
          router.push("/dashboard");
        }, 3000);
      } finally {
        setLoading(false);
      }
    }
    
    fetchUserProfile();
  }, [supabase, router]);

  // Handle successful payment link generation
  const handleSuccess = () => {
    // Analytics or additional actions could be added here
  };

  // Handle errors in payment link generation
  const handleError = (errorMessage: string) => {
    console.error("Payment link generation error:", errorMessage);
  };

  if (loading) {
    return (
      <div className="container flex items-center justify-center min-h-[70vh]">
        <Card className="w-full max-w-md p-6">
          <CardContent className="flex flex-col items-center justify-center space-y-4">
            <Loader2 className="h-12 w-12 animate-spin text-primary" />
            <p className="text-lg text-center">Loading your profile...</p>
          </CardContent>
        </Card>
      </div>
    );
  }

  if (error) {
    return (
      <div className="container flex items-center justify-center min-h-[70vh]">
        <Card className="w-full max-w-md p-6 border-destructive">
          <CardContent className="flex flex-col items-center justify-center space-y-4">
            <div className="rounded-full bg-destructive/10 p-3">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
                className="h-8 w-8 text-destructive"
              >
                <circle cx="12" cy="12" r="10" />
                <line x1="12" y1="8" x2="12" y2="12" />
                <line x1="12" y1="16" x2="12.01" y2="16" />
              </svg>
            </div>
            <p className="text-lg font-medium text-center text-destructive">{error}</p>
            <p className="text-sm text-center">Redirecting you to dashboard...</p>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="container py-10">
      <h1 className="text-3xl font-bold mb-8 text-center">Generate Payment Link</h1>
      <OnlinePaymentWizard
        missionaryId={profile.id}
        missionaryName={profile.full_name}
        onSuccess={handleSuccess}
        onError={handleError}
      />
    </div>
  );
} 