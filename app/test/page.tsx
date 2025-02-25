'use client';

import { Button } from '@/components/ui/button';
import { useState, useEffect } from 'react';
import { useToast } from '@/components/ui/use-toast';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { createClient } from '@/utils/supabase/client';

interface Donation {
  id: number;
  donor_id: number;
  missionary_id: string;
  amount: number;
  date: string;
  source: string;
  status: string;
  notes?: string;
  xendit_invoice_id?: string;
  xendit_payment_id?: string;
  payment_method?: string;
  payment_channel?: string;
  payment_timestamp?: string;
  batch_id?: string;
}

export default function TestPage() {
  const [invoiceId, setInvoiceId] = useState('');
  const [donations, setDonations] = useState<Donation[]>([]);
  const [missionaryId, setMissionaryId] = useState('');
  const { toast } = useToast();
  const supabase = createClient();

  useEffect(() => {
    // Get the current user's ID or fetch a test missionary
    const getMissionaryId = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      if (user) {
        const { data: profile } = await supabase
          .from('profiles')
          .select('id, role')
          .eq('id', user.id)
          .single();

        if (profile?.role === 'missionary') {
          setMissionaryId(profile.id);
        } else {
          // If not a missionary, get the first missionary from the database
          const { data: missionary } = await supabase
            .from('profiles')
            .select('id')
            .eq('role', 'missionary')
            .limit(1)
            .single();

          if (missionary) {
            setMissionaryId(missionary.id);
          }
        }
      }
    };

    getMissionaryId();
  }, []);

  useEffect(() => {
    // Subscribe to donation changes
    const channel = supabase
      .channel('donor_donations_changes')
      .on('postgres_changes', {
        event: '*',
        schema: 'public',
        table: 'donor_donations'
      }, () => {
        fetchDonations();
      })
      .subscribe();

    return () => {
      channel.unsubscribe();
    };
  }, []);

  const fetchDonations = async () => {
    const { data } = await supabase
      .from('donor_donations')
      .select('*')
      .order('created_at', { ascending: false })
      .limit(10);

    if (data) {
      setDonations(data);
    }
  };

  const testManualRemittance = async () => {
    if (!missionaryId) {
      toast({
        title: 'Error',
        description: 'No missionary ID available',
        variant: 'destructive',
      });
      return;
    }

    try {
      // Test payload
      const testPayload = {
        donations: [
          {
            donor_name: "Test Donor 1",
            amount: 1000,
            notes: "Test donation 1"
          },
          {
            donor_name: "Test Donor 2",
            amount: 2000,
            notes: "Test donation 2"
          }
        ],
        missionary_id: missionaryId,
        total_amount: 3000,
        notes: "Test batch remittance"
      };

      const response = await fetch('/api/manual-remittance', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(testPayload)
      });
      
      const data = await response.json();
      
      if (data.error) {
        throw new Error(data.error);
      }

      setInvoiceId(data.invoice_id);
      toast({
        title: 'Manual Remittance Created',
        description: `Invoice URL: ${data.invoice_url}`,
      });

      // Open invoice URL in new tab
      window.open(data.invoice_url, '_blank');
    } catch (error: any) {
      toast({
        title: 'Error',
        description: error.message,
        variant: 'destructive',
      });
    }
  };

  const testWebhook = async () => {
    if (!invoiceId) {
      toast({
        title: 'Error',
        description: 'No invoice ID available. Create a manual remittance first.',
        variant: 'destructive',
      });
      return;
    }

    try {
      // Simulate a webhook call
      const testPayload = {
        event: "invoice.paid",
        invoice_id: invoiceId,
        payment_method: "BANK_TRANSFER",
        payment_channel: "BPI",
        payment_id: "test_payment_" + Date.now(),
        status: "PAID",
        paid_amount: 3000
      };

      const response = await fetch('/api/xendit-webhook', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'x-callback-token': 'DfHz2IsSz1ErauIztRvCpGEVw0a1I4KbwgrO69EmFJlFl24z'
        },
        body: JSON.stringify(testPayload)
      });
      
      const data = await response.json();
      
      if (data.error) {
        throw new Error(data.error);
      }

      toast({
        title: 'Webhook Test Completed',
        description: 'Check the database for updated status',
      });

      // Refresh donations
      fetchDonations();
    } catch (error: any) {
      toast({
        title: 'Error',
        description: error.message,
        variant: 'destructive',
      });
    }
  };

  return (
    <div className="p-4 space-y-4">
      <h1 className="text-2xl font-bold">Manual Remittance Testing</h1>
      
      <div className="space-y-2">
        <Button onClick={testManualRemittance} disabled={!missionaryId}>
          Test Manual Remittance
        </Button>
        
        <Button onClick={testWebhook} disabled={!invoiceId}>
          Simulate Webhook (Payment Success)
        </Button>
      </div>

      {missionaryId && (
        <Card>
          <CardHeader>
            <CardTitle>Test Configuration</CardTitle>
          </CardHeader>
          <CardContent>
            <p>Missionary ID: {missionaryId}</p>
            {invoiceId && <p>Current Invoice ID: {invoiceId}</p>}
          </CardContent>
        </Card>
      )}

      <Card>
        <CardHeader>
          <CardTitle>Recent Donations</CardTitle>
        </CardHeader>
        <CardContent>
          <pre className="bg-gray-100 p-4 rounded overflow-auto">
            {JSON.stringify(donations, null, 2)}
          </pre>
        </CardContent>
      </Card>
    </div>
  );
} 