// components/ChurchesList.tsx
"use client";

import { useState, useEffect } from "react";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import EditChurchModal from "./EditChurchModal";

interface Church {
  id: number;
  name: string;
  lead_pastor_id: string | null;
}

interface LeadPastor {
  id: string;
  full_name: string;
}

interface ChurchesListProps {
  churches: Church[];
  leadPastors: LeadPastor[];
}

export default function ChurchesList({ churches, leadPastors }: ChurchesListProps) {
  const [selectedChurch, setSelectedChurch] = useState<Church | null>(null);
  const [modalOpen, setModalOpen] = useState(false);


  const handleEditClick = (church: Church) => {
    setSelectedChurch(church);
    setModalOpen(true);
  };

  return (
    <Card>
      <CardHeader className="flex justify-between items-center">
        <CardTitle>Local Churches</CardTitle>
        <Button variant="outline">Add Church</Button>
      </CardHeader>
      <CardContent>
        {churches.length > 0 ? (
          <table className="min-w-full text-left">
            <thead>
              <tr>
                <th className="px-4 py-2">ID</th>
                <th className="px-4 py-2">Name</th>
                <th className="px-4 py-2">Lead Pastor</th>
                <th className="px-4 py-2">Actions</th>
              </tr>
            </thead>
            <tbody>
              {churches.map((church) => {
                const leadPastorName = church.lead_pastor_id
                  ? leadPastors.find(lp => lp.id === church.lead_pastor_id)?.full_name || "Unassigned"
                  : "Unassigned";
                return (
                  <tr key={church.id}>
                    <td className="border px-4 py-2">{church.id}</td>
                    <td className="border px-4 py-2">{church.name}</td>
                    <td className="border px-4 py-2">{leadPastorName}</td>
                    <td className="border px-4 py-2">
                      <Button variant="outline" size="sm" onClick={() => handleEditClick(church)}>
                        Edit
                      </Button>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        ) : (
          <p>No churches found.</p>
        )}
      </CardContent>

      {selectedChurch && (
        <EditChurchModal
          open={modalOpen}
          onOpenChange={setModalOpen}
          church={selectedChurch}
          leadPastors={leadPastors}
        />
      )}
    </Card>
  );
}
