import { createClient } from '@/utils/supabase/server'
import { redirect } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { LeadPastorApprovalCard } from '@/components/LeadPastorApprovalCard'
import LeadPastorSelector from '@/components/LeadPastorSelector'

export default async function LeadPastorDashboard({
  searchParams,
}: { searchParams: Promise<{ [key: string]: string | string[] | undefined }> }) {
  // Await the search params before using them
  const resolvedSearchParams = await searchParams;

  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect('/login');
  }

  // Determine the selected lead pastor id (acting as proxy login):
  const selectedLeadPastorId =
    typeof resolvedSearchParams.userId === 'string'
      ? resolvedSearchParams.userId
      : Array.isArray(resolvedSearchParams.userId)
      ? resolvedSearchParams.userId[0]
      : user.id;

  // Fetch lead pastors for profile selection
  const { data: leadPastors, error: leadPastorsError } = await supabase
    .from('profiles')
    .select('id, full_name, role')
    .eq('role', 'lead_pastor');

  if (leadPastorsError) {
    console.error('Error fetching lead pastors', leadPastorsError);
  }

  // Fetch pending leave requests where lead pastor has not acted.
  // We embed the requester's profile with its related local church using the fk_local_church alias.
  // Then we filter using the embedded church's "lead_pastor_id".
  const { data: leaveRequests, error: leaveError } = await supabase
    .from('leave_requests')
    .select(`
      id,
      type,
      start_date,
      end_date,
      reason,
      status,
      created_at,
      campus_director_approval,
      lead_pastor_approval,
      requester:profiles(full_name, local_churches!fk_local_church(lead_pastor_id))
    `)
    .eq('lead_pastor_approval', 'none')
    .eq('requester.local_churches!fk_local_church.lead_pastor_id', selectedLeadPastorId)
    .order('created_at', { ascending: false });

  // Fetch pending surplus requests where lead pastor has not acted.
  // We embed the missionary's profile (aliased as "missionary") with its related local church using the fk_local_church alias.
  // Then we filter using the embedded church's "lead_pastor_id".
  const { data: surplusRequests, error: surplusError } = await supabase
    .from('surplus_requests')
    .select(`
      id,
      amount_requested,
      reason,
      status,
      created_at,
      campus_director_approval,
      lead_pastor_approval,
      missionary:profiles(full_name, local_churches!fk_local_church(lead_pastor_id))
    `)
    .eq('lead_pastor_approval', 'none')
    .eq('missionary.local_churches!fk_local_church.lead_pastor_id', selectedLeadPastorId)
    .order('created_at', { ascending: false });

  if (leaveError || surplusError) {
    console.error('Error fetching pending requests', leaveError, surplusError);
  }

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-7xl mx-auto p-6 space-y-8">
        <header>
          <h1 className="text-3xl font-bold text-foreground">Lead Pastor Dashboard</h1>
          <p className="text-lg text-muted-foreground mt-1">Final approvals and church oversight</p>
        </header>

        {/* Lead Pastor Profile Selector */}
        <div className="mb-6">
          <LeadPastorSelector leadPastors={leadPastors || []} userId={selectedLeadPastorId} />
        </div>

        <div className="space-y-6">
          <h2 className="text-2xl font-semibold">Pending Leave Requests</h2>
          {leaveRequests?.length ? (
            leaveRequests.map((request) => (
              <LeadPastorApprovalCard
                key={request.id}
                request={{
                  id: request.id,
                  type: request.type,
                  startDate: request.start_date,
                  endDate: request.end_date,
                  reason: request.reason,
                  status: request.status,
                  createdAt: request.created_at,
                  campusDirector: request.campus_director_approval,
                  leadPastor: request.lead_pastor_approval,
                  requester: request.requester?.full_name || 'Unknown',
                  category: 'leave'
                }}
              />
            ))
          ) : (
            <p className="text-muted-foreground">No pending leave requests.</p>
          )}
        </div>

        <div className="space-y-6 mt-8">
          <h2 className="text-2xl font-semibold">Pending Surplus Requests</h2>
          {surplusRequests?.length ? (
            surplusRequests.map((request) => (
              <LeadPastorApprovalCard
                key={request.id}
                request={{
                  id: request.id,
                  type: 'Surplus',
                  amount: request.amount_requested,
                  reason: request.reason,
                  status: request.status,
                  createdAt: request.created_at,
                  campusDirector: request.campus_director_approval,
                  leadPastor: request.lead_pastor_approval,
                  requester: request.missionary?.full_name || 'Unknown',
                  category: 'surplus'
                }}
              />
            ))
          ) : (
            <p className="text-muted-foreground">No pending surplus requests.</p>
          )}
        </div>
      </div>
    </div>
  );
} 