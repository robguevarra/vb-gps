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
import { createClient as supabaseCreateClient } from '@supabase/supabase-js'

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

    try {
      const response = await fetch('/api/users/create', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          fullName,
          email,
          role,
          churchId: churchId === "none" ? null : parseInt(churchId),
          monthlyGoal
        })
      });

      const result = await response.json();
      
      if (!response.ok) throw new Error(result.error || "Failed to create user");

      toast({
        title: "Success",
        description: "Staff member created successfully",
        variant: "success",
      });
      onOpenChange(false);
      setTimeout(() => {
        window.location.reload();
      }, 3000);

    } catch (err: any) {
      console.error("Creation error:", err);
      setError(err.message);
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