// components/EditChurchModal.tsx
"use client";

import { useState } from "react";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Select, SelectTrigger, SelectValue, SelectContent, SelectItem } from "@/components/ui/select";
import { Button } from "@/components/ui/button";
import { Loader2 } from "lucide-react";
import { createClient } from "@/utils/supabase/client";

interface Church {
  id: number;
  name: string;
  lead_pastor_id: string | null;
}

interface LeadPastor {
  id: string;
  full_name: string;
}

interface EditChurchModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  church: Church;
  leadPastors: LeadPastor[];
}

export default function EditChurchModal({
  open,
  onOpenChange,
  church,
  leadPastors,
}: EditChurchModalProps) {
  const supabase = createClient();
  const [name, setName] = useState(church.name);
  // Set default to "none" if there's no assigned lead pastor.
  const [leadPastorId, setLeadPastorId] = useState(church.lead_pastor_id || "none");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const handleSave = async () => {
    console.log("Saving update for church:", church.id, { name, leadPastorId });
    setLoading(true);
    setError("");

    const updateData: Record<string, any> = {
      name,
      lead_pastor_id: leadPastorId === "none" ? null : leadPastorId,
    };

    const { error: updateError } = await supabase
      .from("local_churches")
      .update(updateData)
      .eq("id", church.id);

    if (updateError) {
      console.error("Update error:", updateError);
      setError(updateError.message);
      setLoading(false);
      return;
    }

    console.log("Update successful for church:", church.id);
    setLoading(false);
    onOpenChange(false);
    window.location.reload();
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Edit Church</DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <div>
            <Label htmlFor="churchName">Church Name</Label>
            <Input
              id="churchName"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="Enter church name"
            />
          </div>
          <div>
            <Label>Lead Pastor</Label>
            <Select value={leadPastorId} onValueChange={(val) => setLeadPastorId(val)}>
              <SelectTrigger className="w-full mt-1">
                <SelectValue placeholder="Unassigned" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="none">Unassigned</SelectItem>
                {leadPastors.map((lp) => (
                  <SelectItem key={lp.id} value={lp.id}>
                    {lp.full_name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
          {error && <p className="text-red-600 text-sm">{error}</p>}
          <div className="flex justify-end gap-2 pt-2">
            <Button variant="secondary" onClick={() => onOpenChange(false)}>
              Cancel
            </Button>
            <Button onClick={handleSave} disabled={loading}>
              {loading ? <Loader2 className="animate-spin mr-2 h-4 w-4" /> : null}
              Save
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}
