'use client'

import { useState, useEffect, useCallback } from 'react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { createClient } from '@/utils/supabase/client'
import { Plus, Trash, CheckCircle, Loader2 } from 'lucide-react'
import { toast } from '@/hooks/use-toast'

interface ManualRemittanceWizardProps {
  missionaryId: string;
}

interface Donor {
  id: string;
  name: string;
}

export function ManualRemittanceWizard({ missionaryId }: ManualRemittanceWizardProps) {
  const supabase = createClient();
  const [step, setStep] = useState<1 | 2>(1);
  const [totalAmount, setTotalAmount] = useState('');
  const [donorEntries, setDonorEntries] = useState<{ donorId: string; amount: string; donorName?: string }[]>([{ donorId: '', amount: '' }]);
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [searchResults, setSearchResults] = useState<Donor[]>([]);
  const [searchLoading, setSearchLoading] = useState(false);

  // Debounced Search
  const debouncedSearch = useCallback(
    debounce(async (term: string) => {
      setSearchLoading(true);
      try {
        let query = supabase.from('donors').select('id, name');

        if (term.trim()) {
          query = query.textSearch('name', term, {
            type: 'websearch',
            config: 'english',
          });
        } else {
          query = query.order('created_at', { ascending: false }).limit(10); // Show recent donors
        }

        const { data, error } = await query;
        if (!error) {
          setSearchResults(data || []);
        }
      } catch (error) {
        toast({ title: 'Search Error', description: 'Failed to fetch donors' });
      } finally {
        setSearchLoading(false);
      }
    }, 300),
    []
  );

  // Handle search term changes
  useEffect(() => {
      debouncedSearch(searchTerm);
  }, [searchTerm, debouncedSearch]);


  const handleCreateDonor = async (name: string) => {
    setLoading(true);
    try {
      const { data: newDonor, error } = await supabase
        .from('donors')
        .insert({ name })
        .select()
        .single();

      if (error) throw error;

      // Add the new donor to the *searchResults* so it appears immediately
      setSearchResults(prevResults => [...prevResults, newDonor]);
      return newDonor.id;

    } catch (error) {
      toast({ title: 'Error creating donor', description: error.message, variant: 'destructive' });
    } finally {
      setLoading(false);
    }
  };

  const handleSelectDonor = (index: number, donor: Donor) => {
    const newEntries = [...donorEntries];
    newEntries[index] = { ...newEntries[index], donorId: donor.id, donorName: donor.name };
    setDonorEntries(newEntries);
    setSearchTerm(''); // Clear search term after selection
    setSearchResults([]); // Clear search results
  };

  const handleAddDonorEntry = () => {
    setDonorEntries([...donorEntries, { donorId: '', amount: '', donorName: '' }]);
  };

  const handleRemoveDonorEntry = (index: number) => {
    setDonorEntries(donorEntries.filter((_, i) => i !== index));
  };

    const validateStep1 = () => {
        const total = parseFloat(totalAmount);
        return !isNaN(total) && total > 0;
    };

    const validateStep2 = () => {
        const sum = donorEntries.reduce((acc, entry) => {
            const amount = parseFloat(entry.amount);
            return acc + (isNaN(amount) ? 0 : amount);
        }, 0);

        return (
            Math.abs(sum - parseFloat(totalAmount)) <= 0.01 &&
            donorEntries.every(entry =>
                String(entry.donorId).trim() !== '' &&
                !isNaN(parseFloat(entry.amount)) &&
                parseFloat(entry.amount) > 0
            )
        );
    };

  const handleSubmit = async () => {
    setLoading(true)
    try {
      const entries = await Promise.all(donorEntries.map(async (entry) => {
        const amount = parseFloat(entry.amount)
        return {
          donor_id: entry.donorId,
          amount,
          missionary_id: missionaryId,
          date: new Date().toISOString(),
          source: 'offline',
          status: 'completed'
        }
      }))

      const { error } = await supabase
        .from('donor_donations')
        .insert(entries)

      if (error) throw error

      setSuccess(true)
      setTimeout(() => {
        setSuccess(false)
        setStep(1)
        setTotalAmount('')
        setDonorEntries([{ donorId: '', amount: '' }])
      }, 2000)

      toast({
        title: 'Remittance submitted successfully!',
        description: 'The donations have been recorded.',
      })
    } catch (error) {
      toast({
        title: 'Submission failed',
        description: error.message,
        variant: 'destructive'
      })
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="space-y-8 max-w-2xl mx-auto">
      <div className="text-center space-y-2">
        <h2 className="text-2xl font-bold">Manual Remittance</h2>
        <p className="text-muted-foreground">
          {step === 1 ? 'Enter total amount' : 'Distribute donations to donors'}
        </p>
      </div>

      <div className="relative">
        {/* Success overlay */}
        {success && (
          <div className="absolute inset-0 bg-background/90 flex items-center justify-center rounded-lg">
            <div className="text-center space-y-4">
              <CheckCircle className="h-12 w-12 text-green-500 mx-auto animate-bounce" />
              <p className="font-semibold">Remittance recorded successfully!</p>
            </div>
          </div>
        )}

        {/* Step 1: Total Amount */}
        {step === 1 && (
          <div className="space-y-6">
            <div className="space-y-2">
              <Label>Total Amount</Label>
              <Input
                type="number"
                value={totalAmount}
                onChange={(e) => setTotalAmount(e.target.value)}
                placeholder="0.00"
                className="text-2xl h-16 text-center"
              />
            </div>
            
            <Button
              size="lg"
              className="w-full"
              onClick={() => setStep(2)}
              disabled={!validateStep1()}
            >
              Next: Assign Donors
            </Button>
          </div>
        )}

        {/* Step 2: Donor Distribution */}
        {step === 2 && (
          <div className="space-y-6">
            <div className="space-y-4">
              {donorEntries.map((entry, index) => (
                <div key={index} className="flex gap-4 items-start">
                  <div className="flex-1 space-y-2">
                    <Label>Donor {index + 1}</Label>

                    {/* Search Input */}
                    <Input
                      type="text"
                      placeholder="Search for a donor..."
                      value={entry.donorName || searchTerm} // Display selected donor name, otherwise show search term
                      onChange={(e) => {
                          if (entry.donorId) { // If a donor is already selected, don't allow changing the name
                              return;
                          }
                          setSearchTerm(e.target.value)
                      }}
                      disabled={!!entry.donorId} // Disable input if a donor is already selected
                    />

                    {/* Search Results */}
                    {(searchTerm.trim() && !entry.donorId) && ( // Only show if searching and no donor selected
                      <div className="border rounded-md shadow-sm">
                        {searchLoading && (
                          <div className="p-2 text-muted-foreground">
                            <Loader2 className="mr-2 h-4 w-4 animate-spin" /> Searching...
                          </div>
                        )}
                        {!searchLoading && searchResults.length > 0 && (
                          <ul className="py-1">
                            {searchResults.map((donor) => (
                              <li
                                key={donor.id}
                                className="p-2 hover:bg-gray-100 cursor-pointer"
                                onClick={() => handleSelectDonor(index, donor)}
                              >
                                {donor.name}
                              </li>
                            ))}
                          </ul>
                        )}
                        {!searchLoading && searchResults.length === 0 && (
                          <div className="p-2 text-muted-foreground">No donors found.</div>
                        )}
                      </div>
                    )}

                      {/* Create New Donor Button */}
                      {(!entry.donorId) && (
                          <Button
                              type="button"
                              variant="outline"
                              size="sm"
                              onClick={async () => {
                                  const newDonorId = await handleCreateDonor(searchTerm);
                                  if (newDonorId) {
                                      // Find the newly created donor in searchResults
                                      const newDonor = searchResults.find(d => d.id === newDonorId);
                                      if (newDonor) {
                                          handleSelectDonor(index, newDonor);
                                      }
                                  }
                              }}
                              disabled={!searchTerm.trim()} // Disable if search term is empty
                          >
                              <Plus className="mr-2 h-4 w-4" /> Create New Donor
                          </Button>
                      )}

                    {/* Amount Input */}
                    <div className="space-y-2 w-32">
                      <Label>Amount</Label>
                      <Input
                        type="number"
                        value={entry.amount}
                        onChange={(e) => {
                          const newEntries = [...donorEntries]
                          newEntries[index].amount = e.target.value
                          setDonorEntries(newEntries)
                        }}
                        placeholder="0.00"
                      />
                    </div>

                    {/* Remove Button */}
                    {index > 0 && (
                      <Button
                        variant="ghost"
                        size="icon"
                        className="mt-7"
                        onClick={() => handleRemoveDonorEntry(index)}
                      >
                        <Trash className="h-4 w-4 text-red-500" />
                      </Button>
                    )}
                  </div>
                </div>
              ))}
            </div>

            <div className="flex gap-4">
              <Button
                variant="outline"
                className="flex-1"
                onClick={() => setDonorEntries([...donorEntries, { donorId: '', amount: '' }])}
              >
                <Plus className="mr-2 h-4 w-4" /> Add Donor
              </Button>

              <Button
                size="lg"
                className="flex-1"
                onClick={handleSubmit}
                disabled={!validateStep2() || loading}
              >
                {loading ? (
                  <Loader2 className="h-4 w-4 animate-spin" />
                ) : (
                  'Submit Remittance'
                )}
              </Button>
            </div>

            <Button
              variant="ghost"
              onClick={() => setStep(1)}
            >
              ← Back to Total Amount
            </Button>
          </div>
        )}
      </div>

      {/* Amount Summary */}
      {step === 2 && (
        <div className="p-4 bg-muted rounded-lg">
          <div className="flex justify-between font-medium">
            <span>Total Entered:</span>
            <span>
              ₱{donorEntries.reduce((acc, entry) => acc + (parseFloat(entry.amount) || 0), 0).toLocaleString()}
            </span>
          </div>
          <div className="flex justify-between">
            <span>Declared Total:</span>
            <span>₱{parseFloat(totalAmount).toLocaleString()}</span>
          </div>
        </div>
      )}
    </div>
  )
}

// Helper function for debouncing
function debounce(func: (...args: any[]) => void, delay: number) {
  let timeoutId: NodeJS.Timeout
  return (...args: any[]) => {
    clearTimeout(timeoutId)
    timeoutId = setTimeout(() => func(...args), delay)
  }
} 