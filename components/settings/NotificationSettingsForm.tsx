import { useForm } from "react-hook-form";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { createClient } from "@/utils/supabase/client";
import { useEffect, useState } from "react";
import { toast } from "@/hooks/use-toast";

interface NotificationSettings {
  email_enabled: boolean;
  email_addresses: string;
  sms_enabled: boolean;
  sms_numbers: string;
}

export function NotificationSettingsForm() {
  const supabase = createClient();
  const [isLoading, setIsLoading] = useState(true);
  const { register, handleSubmit, setValue, watch } = useForm<NotificationSettings>();

  useEffect(() => {
    const loadSettings = async () => {
      const { data, error } = await supabase
        .from('notification_settings')
        .select('*')
        .single();

      if (!error && data) {
        setValue('email_enabled', data.email_enabled);
        setValue('email_addresses', data.email_addresses);
        setValue('sms_enabled', data.sms_enabled);
        setValue('sms_numbers', data.sms_numbers);
      }
      setIsLoading(false);
    };
    
    loadSettings();
  }, [setValue]);

  const onSubmit = async (values: NotificationSettings) => {
    const { error } = await supabase
      .from('notification_settings')
      .upsert(values)
      .eq('id', 1);

    if (error) {
      toast.error('Failed to save notification settings');
    } else {
      toast.success('Notification settings updated');
    }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-4 max-w-2xl">
      <div className="space-y-2">
        <div className="flex items-center gap-4">
          <Switch 
            id="email-notifications" 
            checked={watch('email_enabled')}
            onCheckedChange={(val) => setValue('email_enabled', val)}
            disabled={isLoading}
          />
          <Label htmlFor="email-notifications">Email Notifications</Label>
        </div>
        {watch('email_enabled') && (
          <Input
            placeholder="comma-separated emails"
            {...register('email_addresses')}
            disabled={isLoading}
          />
        )}
      </div>

      <div className="space-y-2">
        <div className="flex items-center gap-4">
          <Switch
            id="sms-notifications"
            checked={watch('sms_enabled')}
            onCheckedChange={(val) => setValue('sms_enabled', val)}
            disabled={isLoading}
          />
          <Label htmlFor="sms-notifications">SMS Notifications</Label>
        </div>
        {watch('sms_enabled') && (
          <Input
            placeholder="comma-separated phone numbers"
            {...register('sms_numbers')}
            disabled={isLoading}
          />
        )}
      </div>

      <Button type="submit" disabled={isLoading}>
        {isLoading ? 'Saving...' : 'Save Notifications'}
      </Button>
    </form>
  );
} 