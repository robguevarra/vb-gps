// components/EditUserModal.tsx
"use client";

import { useState, useEffect } from "react";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Select, SelectTrigger, SelectValue, SelectContent, SelectItem } from "@/components/ui/select";
import { Button } from "@/components/ui/button";
import { Loader2 } from "lucide-react";
import { createClient } from "@/utils/supabase/client";
import { toast } from "@/hooks/use-toast";

interface User {
  id: string;
  full_name: string;
  role: string;
  local_church_id: number | null;
  email: string;
  monthly_goal?: number;
}

interface Church {
  id: number;
  name: string;
}

interface EditUserModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  user: User;
  churches: Church[];
}

export default function EditUserModal({
  open,
  onOpenChange,
  user,
  churches,
}: EditUserModalProps) {
  const supabase = createClient();
  const [fullName, setFullName] = useState(user.full_name);
  const [email, setEmail] = useState(user.email);
  const [originalEmail] = useState(user.email);
  const [role, setRole] = useState(user.role);
  const [churchId, setChurchId] = useState(user.local_church_id ? String(user.local_church_id) : "none");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [monthlyGoal, setMonthlyGoal] = useState(
    user.role === 'missionary' ? user.monthly_goal || 0 : 0
  );
  const [errors, setErrors] = useState({
    fullName: '',
    email: '',
    church: '',
    monthlyGoal: ''
  });
  const [deleteConfirmOpen, setDeleteConfirmOpen] = useState(false);
  const [emailConfirmation, setEmailConfirmation] = useState("");
  const [isDeleting, setIsDeleting] = useState(false);

  const roleOptions = ["missionary", "campus_director", "lead_pastor", "finance_officer"];

  useEffect(() => {
    if (user) {
      setFullName(user.full_name);
      setEmail(user.email);
      setRole(user.role);
      setChurchId(user.local_church_id ? String(user.local_church_id) : "none");
      setMonthlyGoal(user.role === 'missionary' ? user.monthly_goal || 0 : 0);
      setErrors({
        fullName: '',
        email: '',
        church: '',
        monthlyGoal: ''
      });
    }
  }, [user]);

  const handleSave = async () => {
    // Confirmation prompt before saving
    if (!window.confirm("Are you sure you want to save these changes?")) {
      toast({ title: "Edit Cancelled", description: "No changes were made." });
      return;
    }

    setLoading(true);
    
    // Clear previous errors
    const newErrors = {
      fullName: '',
      email: '',
      church: '',
      monthlyGoal: ''
    };

    // Validation checks
    if (!fullName.trim()) {
      newErrors.fullName = 'Full name is required';
    }
    if (!email.trim()) {
      newErrors.email = 'Email is required';
    }
    
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (email.trim() && !emailRegex.test(email)) {
      newErrors.email = 'Invalid email format';
    }

    const requiresChurch = ['missionary', 'campus_director'].includes(role);
    if (requiresChurch && churchId === "none") {
      newErrors.church = 'Church assignment is required for this role';
    }

    if (['missionary', 'campus_director'].includes(role) && (monthlyGoal <= 0 || isNaN(monthlyGoal))) {
      newErrors.monthlyGoal = 'Monthly goal must be a positive number';
    }

    if (Object.values(newErrors).some(error => error !== '')) {
      setErrors(newErrors);
      setLoading(false);
      return;
    }

    // Update email if it has changed
    if (email !== originalEmail) {
      const res = await fetch("/api/users/update", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: user.id, email }),
      });
      const result = await res.json();
      if (result.error) {
        console.error("Email update error:", result.error);
        toast({ title: "Email update failed", description: result.error, variant: "destructive" });
        setError(result.error);
        setLoading(false);
        return;
      }
      toast({ title: "Email updated successfully!" });
    }

    // Pre-update check: fetch current profile to confirm it exists.
    const { data: currentProfile, error: profileFetchError } = await supabase
      .from("profiles")
      .select("*")
      .eq("id", user.id);

    if (profileFetchError) {
      console.error("Error fetching current profile:", profileFetchError);
      toast({ title: "Profile fetch failed", description: profileFetchError.message, variant: "destructive" });
      setError(profileFetchError.message);
      setLoading(false);
      return;
    }
    if (!currentProfile || currentProfile.length === 0) {
      console.error("No profile found for user id:", user.id);
      toast({ title: "Profile update failed", description: "No profile found for the given user id.", variant: "destructive" });
      setError("No profile found for the given user id.");
      setLoading(false);
      return;
    }

    // Prepare update data for the profile
    const updateData: Record<string, any> = {
      full_name: fullName,
      role,
      local_church_id: churchId === "none" ? null : parseInt(churchId),
      monthly_goal: ['missionary', 'campus_director'].includes(role) ? Number(monthlyGoal) : null
    };


    // Attempt to update the profiles table and request returning data
    const { data, error: updateError } = await supabase
      .from("profiles")
      .update(updateData)
      .eq("id", user.id)
      .select("*");


    // If no error but no data returned, do a fallback select.
    if (!updateError && (!data || data.length === 0)) {
      console.warn("No rows returned after update. Running fallback select...");
      const { data: fallbackData, error: fallbackError } = await supabase
        .from("profiles")
        .select("*")
        .eq("id", user.id)
        .single();
      if (fallbackError) {
        console.error("Fallback select error:", fallbackError);
        toast({
          title: "Profile update failed",
          description: fallbackError.message,
          variant: "destructive",
        });
        setError(fallbackError.message);
        setLoading(false);
        return;
      }
      // If fallback data indicates the change took place, consider it a success.
      if (fallbackData && fallbackData.full_name === fullName) {
        toast({ title: "Profile updated successfully!" });

      } else {
        console.error("Fallback select did not show the updated data. Data:", fallbackData);
        toast({
          title: "Profile update failed",
          description: "Updated data could not be verified.",
          variant: "destructive",
        });
        setError("Updated data could not be verified.");
        setLoading(false);
        return;
      }
    } else if (updateError) {
      console.error("Profile update error:", updateError, "Data returned:", data);
      toast({
        title: "Profile update failed",
        description: updateError?.message || "No data returned. Check if the user id matches and RLS policies.",
        variant: "destructive",
      });
      setError(updateError?.message || "No data returned");
      setLoading(false);
      return;
    } else {
      toast({ title: "Profile updated successfully!" });
      
    }

    setLoading(false);
    onOpenChange(false);

    // Delay the reload to allow the toast to be visible
    setTimeout(() => {
      window.location.reload();
    }, 2000);
  };

  const handleDelete = async () => {
    if (!window.confirm("Are you absolutely sure you want to delete this user? This action cannot be undone.")) return;
    
    // Final confirmation - user must type email
    if (emailConfirmation !== user.email) {
      toast({
        title: "Deletion aborted",
        description: "Email confirmation does not match",
        variant: "destructive"
      });
      return;
    }

    setIsDeleting(true);
    
    try {
      const response = await fetch('/api/users/delete', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ userId: user.id })
      });

      const result = await response.json();
      
      if (!response.ok) throw new Error(result.error || "Failed to delete user");

      toast({
        title: "✅ User Deleted",
        description: "User account and profile have been permanently removed",
      });
      onOpenChange(false);
      window.location.reload();

    } catch (err: any) {
      console.error("Deletion error:", err);
      toast({
        title: "Deletion failed",
        description: err.message,
        variant: "destructive",
      });
    } finally {
      setIsDeleting(false);
      setDeleteConfirmOpen(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Edit User</DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <div>
            <Label htmlFor="userFullName">Full Name</Label>
            <Input
              id="userFullName"
              value={fullName}
              onChange={(e) => setFullName(e.target.value)}
              placeholder="Enter full name"
            />
            {errors.fullName && <p className="text-red-600 text-sm">{errors.fullName}</p>}
          </div>
          <div>
            <Label htmlFor="userEmail">Email</Label>
            <Input
              id="userEmail"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="Enter email"
            />
            {errors.email && <p className="text-red-600 text-sm">{errors.email}</p>}
          </div>
          <div>
            <Label>Role</Label>
            <Select value={role} onValueChange={(val) => setRole(val)}>
              <SelectTrigger className="w-full mt-1">
                <SelectValue placeholder="Select role" />
              </SelectTrigger>
              <SelectContent>
                {roleOptions.map((r) => (
                  <SelectItem key={r} value={r}>
                    {r}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
          <div>
            <Label>Church Assignment</Label>
            <Select value={churchId} onValueChange={(val) => setChurchId(val)}>
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
            {errors.church && <p className="text-red-600 text-sm">{errors.church}</p>}
          </div>
          {['missionary', 'campus_director'].includes(role) && (
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
              {errors.monthlyGoal && <p className="text-red-600 text-sm">{errors.monthlyGoal}</p>}
            </div>
          )}
          <div className="flex justify-between items-center">
            <Button 
              variant="destructive" 
              onClick={() => setDeleteConfirmOpen(true)}
              disabled={isDeleting}
            >
              {isDeleting ? <Loader2 className="animate-spin mr-2 h-4 w-4" /> : null}
              Delete User
            </Button>
            <div className="flex gap-2">
              <Button variant="secondary" onClick={() => onOpenChange(false)}>
                Cancel
              </Button>
              <Button onClick={handleSave} disabled={loading}>
                {loading ? <Loader2 className="animate-spin mr-2 h-4 w-4" /> : null}
                Save
              </Button>
            </div>
          </div>
        </div>

        {/* Delete confirmation modal */}
        <Dialog open={deleteConfirmOpen} onOpenChange={setDeleteConfirmOpen}>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>Confirm User Deletion</DialogTitle>
            </DialogHeader>
            <div className="space-y-4">
              <p className="text-red-600">
                Warning: This will permanently delete the user account and all associated data.
              </p>
              <div>
                <Label>
                  Type the user's email to confirm:{" "}
                  <span className="font-mono">{user.email}</span>
                </Label>
                <Input
                  value={emailConfirmation}
                  onChange={(e) => setEmailConfirmation(e.target.value)}
                  placeholder="Enter email to confirm"
                />
              </div>
              <div className="flex justify-end gap-2">
                <Button 
                  variant="destructive" 
                  onClick={handleDelete}
                  disabled={emailConfirmation !== user.email || isDeleting}
                >
                  {isDeleting ? <Loader2 className="animate-spin mr-2 h-4 w-4" /> : null}
                  Permanently Delete
                </Button>
                <Button 
                  variant="secondary" 
                  onClick={() => setDeleteConfirmOpen(false)}
                >
                  Cancel
                </Button>
              </div>
            </div>
          </DialogContent>
        </Dialog>
      </DialogContent>
    </Dialog>
  );
}
