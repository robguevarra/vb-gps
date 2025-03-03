import { create } from "zustand";
import { persist, PersistOptions } from "zustand/middleware";

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
 * DonorEntry interface
 * Represents a donor entry in the payment wizard with amount
 */
export interface DonorEntry {
  donorId: string; // Must be a string for API validation
  donorName: string;
  amount: string;
  email?: string;
  phone?: string;
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
  
  // Donor entries (with amounts)
  donorEntries: DonorEntry[];
  
  // Additional information
  notes: string;
  totalAmount: number;
  
  // Actions
  initializeWithMissionary: (missionaryId: string, missionaryName: string) => void;
  addDonor: (donor: Donor) => void;
  removeDonor: (donorId: string) => void;
  updateDonorEntry: (index: number, updates: Partial<DonorEntry>) => void;
  removeDonorEntry: (index: number) => void;
  setNotes: (notes: string) => void;
  resetState: () => void;
  clearStorage: () => void;
}

// Define which parts of the state should be persisted
type PersistedState = Pick<
  PaymentWizardState, 
  'missionaryId' | 'missionaryName' | 'selectedDonors' | 'donorEntries' | 'notes' | 'totalAmount'
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
    donorEntries: state.donorEntries,
    notes: state.notes,
    totalAmount: state.totalAmount
  }),
  // Add version to handle storage migrations
  version: 2
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
      donorEntries: [],
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
        const { selectedDonors, donorEntries } = get();
        
        // Only add if not already selected
        if (!selectedDonors[donor.id]) {
          // Add to selected donors
          const updatedDonors = {
            ...selectedDonors,
            [donor.id]: donor
          };
          
          // Create a donor entry with empty amount
          const newEntry: DonorEntry = {
            donorId: String(donor.id), // Ensure donorId is a string for API validation
            donorName: donor.name,
            amount: '',
            email: donor.email,
            phone: donor.phone
          };
          
          set({
            selectedDonors: updatedDonors,
            selectedDonorCount: Object.keys(updatedDonors).length,
            donorEntries: [...donorEntries, newEntry]
          });
        }
      },
      
      // Remove a donor from the selected donors
      removeDonor: (donorId) => {
        const { selectedDonors, donorEntries } = get();
        
        // Create a copy without the removed donor
        const { [donorId]: removed, ...updatedDonors } = selectedDonors;
        
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
          totalAmount
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
      
      // Reset the state to initial values
      resetState: () => {
        set({
          selectedDonors: {},
          selectedDonorCount: 0,
          donorEntries: [],
          notes: '',
          totalAmount: 0
        });
      },
      
      // Clear localStorage
      clearStorage: () => {
        if (typeof window !== 'undefined') {
          localStorage.removeItem(STORAGE_KEY);
        }
      }
    }),
    persistConfig
  )
); 