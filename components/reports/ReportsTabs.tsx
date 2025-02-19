import React from "react";
import { Button } from "@/components/ui/button";

interface ReportsTabsProps {
  currentTab: string;
  setCurrentTab: (tab: string) => void;
}

export function ReportsTabs({ currentTab, setCurrentTab }: ReportsTabsProps) {
  const tabs = [
    { key: "missionaries", label: "Missionaries" },
    { key: "churches", label: "Churches" },
    { key: "partners", label: "Partners" },
  ];

  return (
    <div className="flex space-x-2 mb-4">
      {tabs.map((tab) => (
        <Button
          key={tab.key}
          variant={currentTab === tab.key ? "default" : "outline"}
          onClick={() => setCurrentTab(tab.key)}
        >
          {tab.label}
        </Button>
      ))}
    </div>
  );
} 