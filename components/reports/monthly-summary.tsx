'use client'

import { Donation, LeaveRequest, SurplusRequest } from '@/types'
import { formatCurrency } from '@/lib/utils'

export function MonthlySummaryReport({
  donations,
  leaveRequests,
  surplusRequests
}: {
  donations: Donation[]
  leaveRequests: LeaveRequest[]
  surplusRequests: SurplusRequest[]
}) {
  const totalDonations = donations.reduce((sum, d) => sum + d.amount, 0)
  const approvedSurplus = surplusRequests
    .filter(s => s.status === 'approved')
    .reduce((sum, s) => sum + s.amount_requested, 0)
  const pendingLeaveDays = leaveRequests
    .filter(l => l.status === 'pending')
    .reduce((sum, l) => {
      const diff = new Date(l.end_date).getTime() - new Date(l.start_date).getTime()
      return sum + Math.ceil(diff / (1000 * 3600 * 24)) + 1
    }, 0)

  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
      <div className="p-4 bg-card rounded-lg">
        <h3 className="text-sm font-medium">Total Donations</h3>
        <p className="text-2xl font-bold mt-2">{formatCurrency(totalDonations)}</p>
      </div>
      <div className="p-4 bg-card rounded-lg">
        <h3 className="text-sm font-medium">Approved Surplus</h3>
        <p className="text-2xl font-bold mt-2">{formatCurrency(approvedSurplus)}</p>
      </div>
      <div className="p-4 bg-card rounded-lg">
        <h3 className="text-sm font-medium">Pending Leave Days</h3>
        <p className="text-2xl font-bold mt-2">{pendingLeaveDays} days</p>
      </div>
    </div>
  )
} 