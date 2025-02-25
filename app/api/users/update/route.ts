// app/api/users/update/route.ts
import { NextResponse } from "next/server";
import { createClient } from "@/utils/supabase/server";

export async function POST(request: Request) {
  try {
    const { id, email } = await request.json();
    if (!id || !email) {
      console.error("Missing id or email in payload", { id, email });
      return NextResponse.json({ error: "Missing id or email" }, { status: 400 });
    }
    
    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
    if (!supabaseUrl || !supabaseServiceRoleKey) {
      console.error("Missing environment variables", {
        SUPABASE_URL: supabaseUrl ? "SET" : "NOT SET",
        SUPABASE_SERVICE_ROLE_KEY: supabaseServiceRoleKey ? "SET" : "NOT SET",
      });
      return NextResponse.json({ error: "Missing environment variables" }, { status: 500 });
    }
    
    const supabase = await createClient();

    
    // Directly attempt to update the user without a prior lookup.

    const { data, error } = await supabase.auth.admin.updateUserById(id, { email });
    
    if (error) {
      const errorMessage = error.message || "Unknown error";
      return NextResponse.json({ error: errorMessage }, { status: 500 });
    }
    
    return NextResponse.json({ data });
  } catch (error: unknown) {
    console.error("Caught error in API route:", error);
    const errorMessage = error instanceof Error ? error.message : "Unknown error occurred";
    return NextResponse.json({ error: errorMessage }, { status: 500 });
  }
}
