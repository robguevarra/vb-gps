/**
 * Types used across the ManualRemittanceWizard component and its subcomponents
 */

/**
 * Props for the ManualRemittanceWizard component
 */
export interface ManualRemittanceWizardProps {
  /** ID of the user for whom the remittance is being recorded */
  userId: string;
  /** Optional title for the wizard */
  title?: string;
  /** Optional callback function to be called after successful submission */
  onSuccess?: () => void;
  /** Optional callback function to be called after submission failure */
  onError?: (error: string) => void;
}

/**
 * Interface representing a donor in the system
 */
export interface Donor {
  /** Unique identifier for the donor */
  id: string;
  /** Full name of the donor */
  name: string;
  /** Optional email of the donor */
  email?: string;
  /** Optional phone number of the donor */
  phone?: string;
}

/**
 * Interface for a donor entry in the remittance form
 */
export interface DonorEntry {
  /** ID of the donor */
  donorId: string;
  /** Amount contributed by this donor */
  amount: string;
  /** Name of the donor (for display purposes) */
  donorName?: string;
}

/**
 * Interface for new donor form data
 */
export interface NewDonorForm {
  name: string;
  email: string;
  phone: string;
  showForm: boolean;
  emailError?: string;
}