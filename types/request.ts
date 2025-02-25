export interface BaseRequest {
  id: string;
  type: 'Leave' | 'Surplus';
  date: string;
  status: 'approved' | 'rejected' | 'pending';
  reason: string;
}

export interface LeaveRequest extends BaseRequest {
  type: 'Leave';
  startDate: string;
  endDate: string;
}

export interface SurplusRequest extends BaseRequest {
  type: 'Surplus';
  amount: number;
}

export type Request = LeaveRequest | SurplusRequest; 