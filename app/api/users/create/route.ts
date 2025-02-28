import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";

export async function POST(request: Request) {
  try {
    const { fullName, email, role, churchId, monthlyGoal } = await request.json();
    
    const supabase = createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );

    // Create auth user
    const { data: authData, error: authError } = await supabase.auth.admin.createUser({
      email,
      password: "hgmd2024",
      email_confirm: true
    });

    if (authError) throw authError;
    if (!authData.user) throw new Error("User creation failed");

    // Create profile
    const { error: profileError } = await supabase
      .from('profiles')
      .insert([{
        id: authData.user.id,
        full_name: fullName,
        role,
        local_church_id: churchId === "none" ? null : churchId,
        monthly_goal: role === 'missionary' ? monthlyGoal : null
      }]);

    if (profileError) throw profileError;

    return NextResponse.json({ success: true });

  } catch (err: any) {
    console.error("User creation error");
    return NextResponse.json(
      { error: err.message || "Failed to create user" },
      { status: 500 }
    );
  }
} 