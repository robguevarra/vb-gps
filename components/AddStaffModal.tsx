"use client";

import { useState } from "react";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Select, SelectTrigger, SelectValue, SelectContent, SelectItem } from "@/components/ui/select";
import { Button } from "@/components/ui/button";
import { Loader2 } from "lucide-react";
import { createClient } from "@/utils/supabase/client";
import { toast } from "@/hooks/use-toast";

interface Church {
  id: number;
  name: string;
}

interface AddStaffModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  churches: Church[];
}

export default function AddStaffModal({ open, onOpenChange, churches }: AddStaffModalProps) {
  const supabase = createClient();
  const [fullName, setFullName] = useState("");
  const [email, setEmail] = useState("");
  const [role, setRole] = useState("missionary");
  const [churchId, setChurchId] = useState("none");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [monthlyGoal, setMonthlyGoal] = useState(0);

  const roleOptions = ["missionary", "campus_director", "lead_pastor", "finance_officer"];

  const handleCreate = async () => {
    setLoading(true);
    setError("");

    // Basic validation
    if (!fullName || !email) {
      setError("Please fill in all required fields");
      setLoading(false);
      return;
    }

    try {
      // Create auth user
      const { data: authData, error: authError } = await supabase.auth.admin.createUser({
        email,
        password: Math.random().toString(36).slice(-8), // Generate random password
        email_confirm: true,
        user_metadata: {
          full_name: fullName,
          role,
        }
      });

      if (authError) throw authError;
      if (!authData.user) throw new Error("User creation failed");

      // Create profile
      const { error: profileError } = await supabase
        .from("profiles")
        .insert([{
          id: authData.user.id,
          full_name: fullName,
          role,
          local_church_id: churchId === "none" ? null : parseInt(churchId),
          monthly_goal: role === 'missionary' ? Number(monthlyGoal) : null
        }]);

      if (profileError) throw profileError;

      toast({
        title: "Staff member created successfully!",
        description: "An invitation email has been sent to the new staff member.",
      });
      onOpenChange(false);
      window.location.reload();

    } catch (err: any) {
      console.error("Creation error:", err);
      setError(err.message || "Failed to create staff member");
      toast({
        title: "Creation failed",
        description: err.message,
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Add New Staff Member</DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <div>
            <Label htmlFor="fullName">Full Name *</Label>
            <Input
              id="fullName"
              value={fullName}
              onChange={(e) => setFullName(e.target.value)}
              placeholder="Enter full name"
            />
          </div>
          <div>
            <Label htmlFor="email">Email *</Label>
            <Input
              id="email"
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="Enter email"
            />
          </div>
          <div>
            <Label>Role *</Label>
            <Select value={role} onValueChange={setRole}>
              <SelectTrigger className="w-full mt-1">
                <SelectValue placeholder="Select role" />
              </SelectTrigger>
              <SelectContent>
                {roleOptions.map((r) => (
                  <SelectItem key={r} value={r}>
                    {r.replace(/_/g, ' ').toUpperCase()}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
          <div>
            <Label>Church Assignment</Label>
            <Select value={churchId} onValueChange={setChurchId}>
              <SelectTrigger className="w-full mt-1">
                <SelectValue placeholder="Unassigned" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="none">Unassigned</SelectItem>
                {churches.map((ch) => (
                  <SelectItem key={ch.id} value={String(ch.id)}>
                    {ch.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
          {role === 'missionary' && (
            <div>
              <Label htmlFor="monthlyGoal">Monthly Goal (₱)</Label>
              <Input
                id="monthlyGoal"
                type="number"
                value={monthlyGoal}
                onChange={(e) => setMonthlyGoal(Number(e.target.value))}
                min="0"
                step="0.01"
                placeholder="Enter amount in PHP"
              />
            </div>
          )}
          {error && <p className="text-red-600 text-sm">{error}</p>}
          <div className="flex justify-end gap-2 pt-2">
            <Button variant="secondary" onClick={() => onOpenChange(false)}>
              Cancel
            </Button>
            <Button onClick={handleCreate} disabled={loading}>
              {loading ? <Loader2 className="animate-spin mr-2 h-4 w-4" /> : null}
              Create Staff Member
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
} 