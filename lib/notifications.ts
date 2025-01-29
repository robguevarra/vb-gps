import { Resend } from 'resend'
import { ApprovalAction } from '@/types'

const resend = new Resend(process.env.RESEND_API_KEY)

export async function sendApprovalNotification(email: string, action: ApprovalAction) {
  await resend.emails.send({
    from: 'notifications@missionaryportal.com',
    to: email,
    subject: `${action.type} Request ${action.decision}`,
    html: `
      <p>Your ${action.type} request has been ${action.decision}.</p>
      ${action.decision === 'rejected' ? '<p>Reason: ${action.reason || "N/A"}</p>' : ''}
    `
  })
}

export async function sendNewRequestNotification(
  email: string, 
  type: 'surplus' | 'leave',
  requesterName: string
) {
  await resend.emails.send({
    from: 'notifications@missionaryportal.com',
    to: email,
    subject: `New ${type} Request from ${requesterName}`,
    html: `<p>A new ${type} request requires your review in the missionary portal.</p>`
  })
} 