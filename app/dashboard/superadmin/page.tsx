// app/dashboard/superadmin/page.tsx
export const dynamic = "force-dynamic";

import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import SuperAdminSidebar from "@/components/SuperAdminSidebar";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import ChurchesList from "@/components/ChurchesList";

export default async function SuperAdminDashboard({
  searchParams,
}: {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
}) {
  const resolvedSearchParams = await searchParams;
  const currentTab =
    typeof resolvedSearchParams.tab === "string"
      ? resolvedSearchParams.tab
      : "churches";
  console.log("Current Tab:", currentTab);

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  console.log("Authenticated User:", user);

  if (!user) {
    redirect("/login");
  }

  const isSuperAdmin =
    user.email === "robneil@gmail.com" || user.user_metadata?.role === "superadmin";
  if (!isSuperAdmin) {
    redirect("/login");
  }

  const { data: profileData, error: profileError } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", user.id)
    .single();
  if (profileError) {
    console.error("Error fetching profile data:", profileError.message);
  }
  console.log("Profile Data:", profileData);

  // Fetch churches without embedded join.
  const { data: churches, error: churchesError } = await supabase
    .from("local_churches")
    .select("id, name, lead_pastor_id")
    .order("name", { ascending: true });
  if (churchesError) {
    console.error("Error fetching churches:", churchesError.message);
  }
  console.log("Fetched Churches:", churches);

  const { data: leadPastors, error: leadPastorsError } = await supabase
    .from("profiles")
    .select("id, full_name")
    .eq("role", "lead_pastor");
  if (leadPastorsError) {
    console.error("Error fetching lead pastors:", leadPastorsError.message);
  }
  console.log("Fetched Lead Pastors:", leadPastors);

  let content;
  if (currentTab === "churches") {
    content = (
      <ChurchesList
        churches={churches || []}
        leadPastors={leadPastors || []}
      />
    );
  } else if (currentTab === "users") {
    content = (
      <Card>
        <CardHeader className="flex justify-between items-center">
          <CardTitle>User Management</CardTitle>
          <Button variant="outline">Add User</Button>
        </CardHeader>
        <CardContent>
          <p>User management content here...</p>
        </CardContent>
      </Card>
    );
  } else if (currentTab === "reports") {
    content = (
      <Card>
        <CardHeader>
          <CardTitle>Global Donation Report</CardTitle>
        </CardHeader>
        <CardContent>
          <p>Reports content here...</p>
        </CardContent>
      </Card>
    );
  } else if (currentTab === "settings") {
    content = (
      <Card>
        <CardHeader>
          <CardTitle>System Logs & Settings</CardTitle>
        </CardHeader>
        <CardContent>
          <p>Settings content here...</p>
        </CardContent>
      </Card>
    );
  } else {
    content = <p>Invalid section.</p>;
  }

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <div className="flex flex-col lg:flex-row gap-8 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <SuperAdminSidebar />
        <div className="flex-1 lg:ml-64">
          <header className="mb-8">
            <h1 className="text-3xl font-semibold text-gray-900 dark:text-gray-100">
              {profileData?.full_name || user.email}
            </h1>
            <div className="flex items-center gap-2 mt-1">
              <p className="text-sm text-gray-500 dark:text-gray-400">
                {profileData?.role === "superadmin"
                  ? "superadmin"
                  : profileData?.role || "user"}
              </p>
            </div>
          </header>
          <div className="space-y-8">{content}</div>
        </div>
      </div>
    </div>
  );
}
