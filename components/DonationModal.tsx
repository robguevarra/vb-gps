//components/DonationModal.tsx
"use client";

import { useState, useRef } from "react";
import { useRouter } from "next/navigation"; // <-- Import for router.refresh()
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger
} from "@/components/ui/dialog";

interface DonationModalProps {
  missionaries: any[];
}

export default function DonationModal({ missionaries }: DonationModalProps) {
  const [open, setOpen] = useState(false);
  const [donorName, setDonorName] = useState("");
  const [amount, setAmount] = useState("");
  const [date, setDate] = useState("");
  const [missionaryId, setMissionaryId] = useState("");
  const [donorEmail, setDonorEmail] = useState("");
  const [donorPhone, setDonorPhone] = useState("");
  const [donorSuggestions, setDonorSuggestions] = useState<any[]>([]);
  const [isLoadingSuggestions, setIsLoadingSuggestions] = useState(false);
  const timeoutRef = useRef<NodeJS.Timeout | null>(null);
  const [donorSelected, setDonorSelected] = useState(false);
  const [notes, setNotes] = useState("");
  const router = useRouter(); // <-- We'll call router.refresh() after success

  const handleDonorNameChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const value = e.target.value;
    setDonorName(value);
    setDonorSelected(false);
    if (timeoutRef.current) {
      clearTimeout(timeoutRef.current);
    }
    if (!value) {
      setDonorSuggestions([]);
      return;
    }
    timeoutRef.current = setTimeout(async () => {
      setIsLoadingSuggestions(true);
      try {
        const res = await fetch(`/api/donors/suggestions?search=${encodeURIComponent(value)}`);
        if (res.ok) {
          const data = await res.json();
          setDonorSuggestions(data.donors || []);
          console.log("[DonationModal] Fetched donor suggestions:", data.donors);
        } else {
          console.error("[DonationModal] Failed to fetch donor suggestions");
          setDonorSuggestions([]);
        }
      } catch (error) {
        console.error("[DonationModal] Error fetching donor suggestions:", error);
        setDonorSuggestions([]);
      } finally {
        setIsLoadingSuggestions(false);
      }
    }, 500);
  };

  const handleSuggestionClick = (donor: any) => {
    setDonorName(donor.name);
    setDonorEmail(donor.email || "");
    setDonorPhone(donor.phone || "");
    setDonorSuggestions([]);
    setDonorSelected(true);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const payload = {
      donor_name: donorName,
      donor_email: donorEmail,
      donor_phone: donorPhone,
      amount: parseFloat(amount),
      date,
      missionary_id: missionaryId,
      notes
    };
    console.log("[DonationModal] Submitting donation with payload:", payload);
    try {
      const response = await fetch("/api/donations", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload)
      });
      if (response.ok) {
        console.log("[DonationModal] Donation recorded successfully");
        // Refresh SSR data
        router.refresh(); // <-- TRIGGER RE-FETCH OF SERVER DATA

        // Reset form fields on success
        setOpen(false);
        setDonorName("");
        setDonorEmail("");
        setDonorPhone("");
        setAmount("");
        setDate("");
        setMissionaryId("");
        setNotes("");
        setDonorSuggestions([]);
      } else {
        const errorData = await response.json();
        console.error("[DonationModal] Failed to record donation:", errorData.error);
      }
    } catch (error) {
      console.error("[DonationModal] Error submitting donation:", error);
    }
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button>Record Donation</Button>
      </DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Record Donation</DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="flex flex-col">
            <label htmlFor="missionary">Select Missionary</label>
            <select
              id="missionary"
              value={missionaryId}
              onChange={(e) => setMissionaryId(e.target.value)}
              required
              className="mt-1 rounded-md border p-2"
            >
              <option value="">Select Missionary</option>
              {missionaries.map((m: any) => (
                <option key={m.id} value={m.id}>
                  {m.full_name}
                </option>
              ))}
            </select>
          </div>
          <div className="flex flex-col relative">
            <label htmlFor="donorName" className="text-sm font-medium">Donor Name</label>
            <input
              id="donorName"
              type="text"
              value={donorName}
              onChange={handleDonorNameChange}
              placeholder="Type donor name, press Tab to complete"
              required
              className="mt-1 rounded-md border p-2"
            />
            {donorName && !donorSelected && (
              <div className="absolute top-full left-0 z-10 w-full bg-white border rounded-md mt-1 max-h-40 overflow-y-auto">
                {isLoadingSuggestions ? (
                  <div className="p-2 text-sm text-gray-500">Loading...</div>
                ) : donorSuggestions.length > 0 ? (
                  donorSuggestions.map((donor) => (
                    <div
                      key={donor.id}
                      className="p-2 hover:bg-gray-100 cursor-pointer text-sm"
                      onClick={() => handleSuggestionClick(donor)}
                    >
                      {donor.name} {donor.email ? `(${donor.email})` : ""} <span className="text-xs text-gray-400">Press Tab to complete</span>
                    </div>
                  ))
                ) : (
                  <div className="p-2 text-sm text-gray-500">
                    No existing donor found, new donor will be created.
                  </div>
                )}
              </div>
            )}
          </div>
          <div className="flex flex-col">
            <label htmlFor="donorEmail" className="text-sm font-medium">Donor Email (optional)</label>
            <input
              id="donorEmail"
              type="email"
              value={donorEmail}
              onChange={(e) => setDonorEmail(e.target.value)}
              className="mt-1 rounded-md border p-2"
            />
          </div>
          <div className="flex flex-col">
            <label htmlFor="donorPhone" className="text-sm font-medium">Donor Phone (optional)</label>
            <input
              id="donorPhone"
              type="tel"
              value={donorPhone}
              onChange={(e) => setDonorPhone(e.target.value)}
              className="mt-1 rounded-md border p-2"
            />
          </div>
          <div className="flex flex-col">
            <label htmlFor="amount" className="text-sm font-medium">Amount</label>
            <input
              id="amount"
              type="number"
              step="0.01"
              value={amount}
              onChange={(e) => setAmount(e.target.value)}
              required
              className="mt-1 rounded-md border p-2"
            />
          </div>
          <div className="flex flex-col">
            <label htmlFor="date" className="text-sm font-medium">Date</label>
            <input
              id="date"
              type="date"
              value={date}
              onChange={(e) => setDate(e.target.value)}
              required
              className="mt-1 rounded-md border p-2"
            />
          </div>
          <div className="flex flex-col">
            <label htmlFor="notes" className="text-sm font-medium">Notes (optional)</label>
            <textarea
              id="notes"
              value={notes}
              onChange={(e) => setNotes(e.target.value)}
              placeholder="Enter any notes regarding this donation"
              className="mt-1 rounded-md border p-2"
            />
          </div>
          <Button type="submit">Submit Donation</Button>
        </form>
      </DialogContent>
    </Dialog>
  );
}
