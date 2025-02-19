"use client"

import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { SystemSettingsForm } from "./SystemSettingsForm";
import { NotificationSettingsForm } from "./NotificationSettingsForm";
import { IntegrationSettingsForm } from "./IntegrationSettingsForm";

export function SettingsLayout() {
  return (
    <Card>
      <CardHeader>
        <CardTitle>System Settings</CardTitle>
      </CardHeader>
      <CardContent>
        <Tabs defaultValue="system" className="w-full">
          <TabsList>
            <TabsTrigger value="system">System</TabsTrigger>
            <TabsTrigger value="notifications">Notifications</TabsTrigger>
            <TabsTrigger value="integrations">Integrations</TabsTrigger>
          </TabsList>
          
          <TabsContent value="system">
            <SystemSettingsForm />
          </TabsContent>
          
          <TabsContent value="notifications">
            <NotificationSettingsForm />
          </TabsContent>
          
          <TabsContent value="integrations">
            <IntegrationSettingsForm />
          </TabsContent>
        </Tabs>
      </CardContent>
    </Card>
  );
} 