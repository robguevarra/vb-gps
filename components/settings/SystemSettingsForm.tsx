import { useForm } from "react-hook-form";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { createClient } from "@/utils/supabase/client";
import { useEffect, useState } from "react";
import { toast } from "@/hooks/use-toast";


interface SystemSettings {
  surplus_allocation: number;
  default_monthly_goal: number;
  leave_request_days: number;
}

export function SystemSettingsForm() {
  const [isLoading, setIsLoading] = useState(true);
  const { register, handleSubmit, reset } = useForm<SystemSettings>();
  const supabase = createClient();

  useEffect(() => {
    const loadSettings = async () => {
      const { data, error } = await supabase
        .from('system_settings')
        .select('*')
        .single();

      if (!error && data) {
        reset(data);
      }
      setIsLoading(false);
    };
    
    loadSettings();
  }, [reset]);

  const onSubmit = async (values: SystemSettings) => {
    const { error } = await supabase
      .from('system_settings')
      .upsert(values)
      .eq('id', 1);

    if (error) {
      toast.error('Failed to save settings');
    } else {
      toast.success('Settings updated successfully');
    }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-4 max-w-2xl">
      <div className="space-y-2">
        <Label>Default Monthly Goal (USD)</Label>
        <Input 
          type="number" 
          {...register('default_monthly_goal', { valueAsNumber: true })}
          disabled={isLoading}
        />
      </div>
      
      <div className="space-y-2">
        <Label>Surplus Allocation (%)</Label>
        <Input
          type="number"
          {...register('surplus_allocation', { valueAsNumber: true })}
          min="0"
          max="100"
          disabled={isLoading}
        />
      </div>
      
      <div className="space-y-2">
        <Label>Max Leave Request Days</Label>
        <Input
          type="number"
          {...register('leave_request_days', { valueAsNumber: true })}
          disabled={isLoading}
        />
      </div>
      
      <Button type="submit" disabled={isLoading}>
        {isLoading ? 'Saving...' : 'Save Settings'}
      </Button>
    </form>
  );
} 