import { create } from "zustand";
import { persist, PersistOptions, createJSONStorage } from "zustand/middleware";
import { safelyRemoveData } from '@/utils/storage';

/**
 * Donor interface
 * Represents a donor in the system
 */
export interface Donor {
  id: string; // Must be a string for API validation
  name: string;
  email?: string;
  phone?: string;
}

/**
 * Partner interface
 * Represents a partner (spouse/family member) of a donor
 */
export interface Partner {
  id: string; // Generated client-side
  donorId: string; // ID of the main donor this partner is associated with
  databaseId?: string; // Actual database ID from the donors table
  name: string;
  email?: string;
  phone?: string;
}

/**
 * DonorEntry interface
 * Represents a donor entry in the payment wizard with amount
 */
export interface DonorEntry {
  donorId: string; // Must be a string for API validation
  donorName: string;
  amount: string;
  email?: string;
  phone?: string;
  partners?: Partner[]; // Added partners field
}

/**
 * PaymentWizardState interface
 * Defines the state and actions for the payment wizard store
 */
export interface PaymentWizardState {
  // Missionary information
  missionaryId: string;
  missionaryName: string;
  
  // Donor selection
  selectedDonors: Record<string, Donor>;
  selectedDonorCount: number;
  
  // Partner selection
  donorPartners: Record<string, Partner[]>;
  
  // Donor entries (with amounts)
  donorEntries: DonorEntry[];
  
  // UI state
  isNewDonorFormOpen: boolean;
  
  // Additional information
  notes: string;
  totalAmount: number;
  
  // Actions
  initializeWithMissionary: (missionaryId: string, missionaryName: string) => void;
  addDonor: (donor: Donor) => void;
  removeDonor: (donorId: string) => void;
  addPartner: (donorId: string, partner: Omit<Partner, 'id' | 'donorId'>) => void;
  removePartner: (donorId: string, partnerId: string) => void;
  updateDonorEntry: (index: number, updates: Partial<DonorEntry>) => void;
  removeDonorEntry: (index: number) => void;
  setNotes: (notes: string) => void;
  setIsNewDonorFormOpen: (isOpen: boolean) => void;
  resetState: () => void;
  clearStorage: () => void;
}

// Define which parts of the state should be persisted
type PersistedState = Pick<
  PaymentWizardState, 
  'missionaryId' | 'missionaryName' | 'selectedDonors' | 'donorPartners' | 'donorEntries' | 'notes' | 'totalAmount' | 'isNewDonorFormOpen'
>;

// Storage key for localStorage
const STORAGE_KEY = "payment-wizard-storage";

// Persist configuration
const persistConfig: PersistOptions<PaymentWizardState, PersistedState> = {
  name: STORAGE_KEY,
  partialize: (state) => ({
    // Only persist these fields to localStorage
    missionaryId: state.missionaryId,
    missionaryName: state.missionaryName,
    selectedDonors: state.selectedDonors,
    donorPartners: state.donorPartners,
    donorEntries: state.donorEntries,
    notes: state.notes,
    totalAmount: state.totalAmount,
    isNewDonorFormOpen: state.isNewDonorFormOpen
  }),
  // Add version to handle storage migrations
  version: 3 // Incremented version for schema change
};

/**
 * Payment Wizard Store
 * 
 * Centralized state management for the payment wizard flow.
 * Handles donor selection, amount entry, and payment processing.
 */
export const usePaymentWizardStore = create<PaymentWizardState>()(
  persist(
    (set, get) => ({
      // Initial state
      missionaryId: '',
      missionaryName: '',
      selectedDonors: {},
      selectedDonorCount: 0,
      donorPartners: {},
      donorEntries: [],
      isNewDonorFormOpen: false,
      notes: '',
      totalAmount: 0,
      
      // Initialize with missionary data
      initializeWithMissionary: (missionaryId, missionaryName) => {
        set({
          missionaryId,
          missionaryName,
        });
      },
      
      // Add a donor to the selected donors
      addDonor: (donor) => {
        const { selectedDonors, donorEntries, donorPartners } = get();
        
        // Only add if not already selected
        if (!selectedDonors[donor.id]) {
          // Add to selected donors
          const updatedDonors = {
            ...selectedDonors,
            [donor.id]: donor
          };
          
          // Initialize empty partners array for this donor if it doesn't exist
          if (!donorPartners[donor.id]) {
            donorPartners[donor.id] = [];
          }
          
          // Create a donor entry with empty amount
          const newEntry: DonorEntry = {
            donorId: String(donor.id), // Ensure donorId is a string for API validation
            donorName: donor.name,
            amount: '',
            email: donor.email,
            phone: donor.phone,
            partners: donorPartners[donor.id] || []
          };
          
          set({
            selectedDonors: updatedDonors,
            selectedDonorCount: Object.keys(updatedDonors).length,
            donorEntries: [...donorEntries, newEntry],
            donorPartners: { ...donorPartners }
          });
        }
      },
      
      // Remove a donor from the selected donors
      removeDonor: (donorId) => {
        const { selectedDonors, donorEntries, donorPartners } = get();
        
        // Create a copy without the removed donor
        const { [donorId]: removed, ...updatedDonors } = selectedDonors;
        
        // Create a copy without the removed donor's partners
        const { [donorId]: removedPartners, ...updatedPartners } = donorPartners;
        
        // Remove any entries for this donor
        const updatedEntries = donorEntries.filter(entry => entry.donorId !== donorId);
        
        // Recalculate total amount
        const totalAmount = updatedEntries.reduce((sum, entry) => {
          const amount = parseFloat(entry.amount) || 0;
          return sum + amount;
        }, 0);
        
        set({
          selectedDonors: updatedDonors,
          selectedDonorCount: Object.keys(updatedDonors).length,
          donorEntries: updatedEntries,
          donorPartners: updatedPartners,
          totalAmount
        });
      },
      
      // Add a partner to a donor
      addPartner: (donorId, partnerData) => {
        const { donorPartners, donorEntries } = get();
        
        // Generate a unique ID for the partner
        const partnerId = `partner_${Date.now()}_${Math.random().toString(36).substring(2, 9)}`;
        
        // Create the partner object
        const partner: Partner = {
          id: partnerId,
          donorId,
          name: partnerData.name,
          email: partnerData.email,
          phone: partnerData.phone
        };
        
        // Add partner to the donor's partners list
        const updatedPartners = {
          ...donorPartners,
          [donorId]: [...(donorPartners[donorId] || []), partner]
        };
        
        // Update the donor entry to include the partner
        const updatedEntries = donorEntries.map(entry => {
          if (entry.donorId === donorId) {
            return {
              ...entry,
              partners: updatedPartners[donorId]
            };
          }
          return entry;
        });
        
        set({
          donorPartners: updatedPartners,
          donorEntries: updatedEntries
        });
      },
      
      // Remove a partner from a donor
      removePartner: (donorId, partnerId) => {
        const { donorPartners, donorEntries } = get();
        
        // Remove the partner from the donor's partners list
        const donorPartnersList = donorPartners[donorId] || [];
        const updatedDonorPartners = donorPartnersList.filter(partner => partner.id !== partnerId);
        
        const updatedPartners = {
          ...donorPartners,
          [donorId]: updatedDonorPartners
        };
        
        // Update the donor entry to reflect the removed partner
        const updatedEntries = donorEntries.map(entry => {
          if (entry.donorId === donorId) {
            return {
              ...entry,
              partners: updatedDonorPartners
            };
          }
          return entry;
        });
        
        set({
          donorPartners: updatedPartners,
          donorEntries: updatedEntries
        });
      },
      
      // Update a donor entry (e.g., amount)
      updateDonorEntry: (index, updates) => {
        const { donorEntries } = get();
        
        // Create updated entries array
        const updatedEntries = [...donorEntries];
        
        // Update the specific entry
        if (index >= 0 && index < updatedEntries.length) {
          updatedEntries[index] = {
            ...updatedEntries[index],
            ...updates
          };
        }
        
        // Recalculate total amount
        const totalAmount = updatedEntries.reduce((sum, entry) => {
          const amount = parseFloat(entry.amount) || 0;
          return sum + amount;
        }, 0);
        
        set({
          donorEntries: updatedEntries,
          totalAmount
        });
      },
      
      // Remove a donor entry
      removeDonorEntry: (index) => {
        const { donorEntries, selectedDonors } = get();
        
        // Create updated entries array without the removed entry
        const updatedEntries = donorEntries.filter((_, i) => i !== index);
        
        // Get the donor ID from the entry being removed
        const removedDonorId = donorEntries[index]?.donorId;
        
        // Create updated selected donors without the removed donor
        const updatedDonors = { ...selectedDonors };
        if (removedDonorId) {
          delete updatedDonors[removedDonorId];
        }
        
        // Recalculate total amount
        const totalAmount = updatedEntries.reduce((sum, entry) => {
          const amount = parseFloat(entry.amount) || 0;
          return sum + amount;
        }, 0);
        
        set({
          donorEntries: updatedEntries,
          selectedDonors: updatedDonors,
          selectedDonorCount: Object.keys(updatedDonors).length,
          totalAmount
        });
      },
      
      // Set notes
      setNotes: (notes) => {
        set({ notes });
      },
      
      // Set isNewDonorFormOpen
      setIsNewDonorFormOpen: (isOpen) => {
        set({ isNewDonorFormOpen: isOpen });
      },
      
      // Reset the state to initial values
      resetState: () => {
        set({
          selectedDonors: {},
          selectedDonorCount: 0,
          donorPartners: {},
          donorEntries: [],
          isNewDonorFormOpen: false,
          notes: '',
          totalAmount: 0
        });
      },
      
      // Clear localStorage
      clearStorage: () => {
        if (typeof window !== 'undefined') {
          safelyRemoveData(STORAGE_KEY);
        }
      }
    }),
    persistConfig
  )
); 