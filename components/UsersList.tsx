// components/UsersList.tsx
"use client";

import { useState, useEffect } from "react";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import EditUserModal from "./EditUserModal";
import AddStaffModal from "./AddStaffModal";

interface User {
  id: string;
  full_name: string;
  role: string;
  local_church_id: number | null;
  email: string;
  monthly_goal?: number | null;
  user_metadata: {
    email?: string;
    [key: string]: any;
  };
}

interface Church {
  id: number;
  name: string;
}

interface UsersListProps {
  users: User[];
  churches: Church[];
}

export default function StaffList({ users, churches }: UsersListProps) {
  const [selectedUser, setSelectedUser] = useState<User | null>(null);
  const [modalOpen, setModalOpen] = useState(false);
  const [addModalOpen, setAddModalOpen] = useState(false);



  const handleEditClick = (user: User) => {
    setSelectedUser(user);
    setModalOpen(true);
  };

  const getChurchName = (churchId: number | null) => {
    if (!churchId) return "Unassigned";
    const church = churches.find((c) => c.id === churchId);
    return church ? church.name : "Unknown";
  };

  return (
    <Card>
      <CardHeader className="flex justify-between items-center">
        <CardTitle>Staff Management</CardTitle>
        <Button variant="outline" onClick={() => setAddModalOpen(true)}>
          Add Staff Member
        </Button>
      </CardHeader>
      <CardContent>
        {users.length > 0 ? (
          <table className="min-w-full text-left">
            <thead>
              <tr>
                <th className="px-4 py-2">ID</th>
                <th className="px-4 py-2">Full Name</th>
                <th className="px-4 py-2">Email</th>
                <th className="px-4 py-2">Role</th>
                <th className="px-4 py-2">Church</th>
                <th className="px-4 py-2">Monthly Goal</th>
                <th className="px-4 py-2">Actions</th>
              </tr>
            </thead>
            <tbody>
              {users.map((user) => (
                <tr key={user.id}>
                  <td className="border px-4 py-2">{user.id}</td>
                  <td className="border px-4 py-2">{user.full_name}</td>
                  <td className="border px-4 py-2">
                    {user.user_metadata?.email || "No email"}
                  </td>
                  <td className="border px-4 py-2">{user.role}</td>
                  <td className="border px-4 py-2">{getChurchName(user.local_church_id)}</td>
                  <td className="border px-4 py-2">
                    {user.role === 'missionary' ? 
                      `₱${user.monthly_goal?.toLocaleString(undefined, { minimumFractionDigits: 2 }) || '0.00'}` : 
                      'N/A'
                    }
                  </td>
                  <td className="border px-4 py-2">
                    <Button variant="outline" size="sm" onClick={() => handleEditClick(user)}>
                      Edit
                    </Button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        ) : (
          <p>No users found.</p>
        )}
      </CardContent>

      <AddStaffModal
        open={addModalOpen}
        onOpenChange={setAddModalOpen}
        churches={churches}
      />

      {selectedUser && (
        <EditUserModal
          open={modalOpen}
          onOpenChange={setModalOpen}
          user={selectedUser}
          churches={churches}
        />
      )}
    </Card>
  );
}
