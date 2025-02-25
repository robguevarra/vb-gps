import React from "react";
import { Button } from "@/components/ui/button";

interface ReportsTabsProps {
  currentTab: "missionaries" | "churches" | "partners";
  setCurrentTab: (tab: "missionaries" | "churches" | "partners") => void;
}

export function ReportsTabs({ currentTab, setCurrentTab }: ReportsTabsProps) {
  return (
    <div className="flex items-center gap-2 mb-4">
      <Button
        variant={currentTab === "missionaries" ? "default" : "outline"}
        onClick={() => setCurrentTab("missionaries")}
      >
        Missionaries
      </Button>
      <Button
        variant={currentTab === "churches" ? "default" : "outline"}
        onClick={() => setCurrentTab("churches")}
      >
        Churches
      </Button>
      <Button
        variant={currentTab === "partners" ? "default" : "outline"}
        onClick={() => setCurrentTab("partners")}
      >
        Partners
      </Button>
    </div>
  );
} 