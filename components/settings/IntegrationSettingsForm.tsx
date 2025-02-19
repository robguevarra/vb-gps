import { useForm } from "react-hook-form";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { createClient } from "@/utils/supabase/client";
import { useEffect, useState } from "react";
import { toast } from "@/hooks/use-toast";

interface IntegrationSettings {
  stripe_enabled: boolean;
  stripe_api_key: string;
  paymongo_enabled: boolean;
  paymongo_api_key: string;
  webhook_url: string;
}

export function IntegrationSettingsForm() {
  const supabase = createClient();
  const [isLoading, setIsLoading] = useState(true);
  const { register, handleSubmit, setValue, watch } = useForm<IntegrationSettings>();

  useEffect(() => {
    const loadSettings = async () => {
      const { data, error } = await supabase
        .from('integration_settings')
        .select('*')
        .single();

      if (!error && data) {
        setValue('stripe_enabled', data.stripe_enabled);
        setValue('stripe_api_key', data.stripe_api_key);
        setValue('paymongo_enabled', data.paymongo_enabled);
        setValue('paymongo_api_key', data.paymongo_api_key);
        setValue('webhook_url', data.webhook_url);
      }
      setIsLoading(false);
    };
    
    loadSettings();
  }, [setValue]);

  const onSubmit = async (values: IntegrationSettings) => {
    const { error } = await supabase
      .from('integration_settings')
      .upsert(values)
      .eq('id', 1);

    if (error) {
      toast.error('Failed to save integration settings');
    } else {
      toast.success('Integration settings updated');
    }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-4 max-w-2xl">
      <div className="space-y-2">
        <div className="flex items-center gap-4">
          <Switch
            id="stripe-enabled"
            checked={watch('stripe_enabled')}
            onCheckedChange={(val) => setValue('stripe_enabled', val)}
            disabled={isLoading}
          />
          <Label htmlFor="stripe-enabled">Enable Stripe Payments</Label>
        </div>
        {watch('stripe_enabled') && (
          <Input
            type="password"
            placeholder="Stripe API Key"
            {...register('stripe_api_key')}
            disabled={isLoading}
          />
        )}
      </div>

      <div className="space-y-2">
        <div className="flex items-center gap-4">
          <Switch
            id="paymongo-enabled"
            checked={watch('paymongo_enabled')}
            onCheckedChange={(val) => setValue('paymongo_enabled', val)}
            disabled={isLoading}
          />
          <Label htmlFor="paymongo-enabled">Enable PayMongo Payments</Label>
        </div>
        {watch('paymongo_enabled') && (
          <Input
            type="password"
            placeholder="PayMongo API Key"
            {...register('paymongo_api_key')}
            disabled={isLoading}
          />
        )}
      </div>

      <div className="space-y-2">
        <Label>Webhook URL</Label>
        <Input
          placeholder="https://example.com/api/webhook"
          {...register('webhook_url')}
          disabled={isLoading}
        />
      </div>

      <Button type="submit" disabled={isLoading}>
        {isLoading ? 'Saving...' : 'Save Integrations'}
      </Button>
    </form>
  );
} 