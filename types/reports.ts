export interface Profile {
  id: string;
  full_name: string;
  monthly_goal: number;
  local_church_id: number | null;
  role: "superadmin" | "campus_director" | "missionary" | "finance_officer" | "lead_pastor";
  surplus_balance: number;
  created_at: string;
}

export interface Church {
  id: number;
  name: string;
}

export interface Donor {
  id: number;
  name: string;
  email: string;
  phone: string;
}

export interface DonorDonation {
  id: number;
  missionary_id: string;
  donor_id: number | null;
  date: string;
  amount: number;
  source: string;
  status: string;
  notes: string | null;
  donors: Donor | null;
}

export type DonationMap = Record<string, Record<string, number>>;

export interface PartnerRow {
  id: number;
  name: string;
  email: string;
  phone: string;
  totalGiven: number;
}

export interface ModalStates {
  missionary: Profile | null;
  church: Church | null;
  partner: PartnerRow | null;
  showMissionaryModal: boolean;
  showChurchModal: boolean;
  showFullMissionaryReport: boolean;
  showPartnerModal: boolean;
}

export interface ReportsData {
  missionaries: Profile[];
  churches: Church[];
  donations: DonorDonation[];
  donationMap: DonationMap;
  thirteenMonthKeys: string[];
  totalDonationsThisMonth: number;
  currentPercentAllMissionaries: number;
  lastMonthPercentAllMissionaries: number;
  countBelow80LastMonth: number;
  enrichedDonors: Array<{
    id: number;
    name: string;
    email: string;
    phone: string;
    totalGiven: number;
  }>;
} 