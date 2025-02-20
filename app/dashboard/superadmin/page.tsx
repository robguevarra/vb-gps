// app/dashboard/superadmin/page.tsx

export const dynamic = "force-dynamic";

import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import SuperAdminSidebar from "@/components/SuperAdminSidebar";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import ChurchesList from "@/components/ChurchesList";
import UsersList from "@/components/UsersList";
import GlobalReportsTab from "@/components/GlobalReportsTab";
import { SettingsLayout } from "@/components/settings/SettingsLayout";
import { getUserRole } from "@/utils/getUserRole";

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
  
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  
  if (!user) {
    redirect("/login");
  }

  // Validate that the user is a superadmin via getUserRole.
  const userRole = await getUserRole(user.id);
  if (userRole !== "superadmin") {
    redirect("/login");
  }

  // Fetch current user's profile.
  const { data: profileData, error: profileError } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", user.id)
    .single();
  if (profileError) {
    console.error("Error fetching profile data:", profileError.message);
  }

  // Fetch churches for the Churches tab.
  const { data: churches, error: churchesError } = await supabase
    .from("local_churches")
    .select("id, name, lead_pastor_id")
    .order("name", { ascending: true });
  if (churchesError) {
    console.error("Error fetching churches:", churchesError.message);
  }

  // Fetch lead pastors for the Churches modal.
  const { data: leadPastors, error: leadPastorsError } = await supabase
    .from("profiles")
    .select("id, full_name")
    .eq("role", "lead_pastor");
  if (leadPastorsError) {
    console.error("Error fetching lead pastors:", leadPastorsError.message);
  }

  // Fetch profiles for users (excluding superadmins).
  const { data: profilesData, error: profilesError } = await supabase
    .from("profiles")
    .select("id, full_name, role, local_church_id, monthly_goal")
    .neq("role", "superadmin")
    .order("full_name", { ascending: true });
  if (profilesError) {
    console.error("Error fetching profiles:", profilesError.message);
  }

  // Fetch auth users (to get emails).
  const { data: authUsersData, error: authUsersError } =
    await supabase.auth.admin.listUsers();
  if (authUsersError) {
    console.error("Error fetching auth users:", authUsersError.message);
  }

  // Merge profiles with auth users to attach emails.
  let users = [];
  if (profilesData && authUsersData && authUsersData.users) {
    users = profilesData.map((profile) => {
      const authUser = authUsersData.users.find((u) => u.id === profile.id);
      return {
        ...profile,
        email: authUser ? authUser.email : "N/A",
        user_metadata: {
          email: authUser ? authUser.email : "N/A",
        },
      };
    });
  }

  // Decide which content to render based on currentTab.
  let content;
  if (currentTab === "churches") {
    content = (
      <ChurchesList
        churches={churches || []}
        leadPastors={leadPastors || []}
      />
    );
  } else if (currentTab === "staff") {
    content = (
      <UsersList
        users={users || []}
        churches={churches || []}
      />
    );
  } else if (currentTab === "reports") {
    content = <GlobalReportsTab />;
  } else if (currentTab === "settings") {
    content = <SettingsLayout />;
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
                {userRole}
              </p>
            </div>
          </header>
          <div className="space-y-8">{content}</div>
        </div>
      </div>
    </div>
  );
}
