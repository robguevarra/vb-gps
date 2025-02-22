"use client"

import { useState, useEffect, useCallback } from "react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { createClient } from "@/utils/supabase/client"
import { Plus, Trash, CheckCircle, Loader2, ArrowLeft, Search, UserPlus } from "lucide-react"
import { toast } from "@/hooks/use-toast"
import { Progress } from "@/components/ui/progress"

interface Partner {
  id: string
  name: string
}

export interface ManualRemittanceWizardProps {
  missionaryId: string
  partners: Array<{ id: string; name: string }>
}

export function ManualRemittanceWizard({ missionaryId, partners }: ManualRemittanceWizardProps) {
  const supabase = createClient()
  const [step, setStep] = useState<1 | 2>(1)
  const [totalAmount, setTotalAmount] = useState("")
  const [donorEntries, setDonorEntries] = useState<{ donorId: string; amount: string; donorName?: string }[]>([
    { donorId: "", amount: "" },
  ])
  const [loading, setLoading] = useState(false)
  const [success, setSuccess] = useState(false)
  const [searchTerm, setSearchTerm] = useState("")
  const [searchResults, setSearchResults] = useState<Partner[]>([])
  const [searchLoading, setSearchLoading] = useState(false)
  const [isCreatingPartner, setIsCreatingPartner] = useState(false)

  // Debounced Search
  const debouncedSearch = useCallback(
    debounce(async (term: string) => {
      setSearchLoading(true)
      try {
        let query = supabase.from("donors").select("id, name")

        if (term.trim()) {
          query = query.textSearch("name", term, {
            type: "websearch",
            config: "english",
          })
        } else {
          query = query.order("created_at", { ascending: false }).limit(10) // Show recent donors
        }

        const { data, error } = await query
        if (!error) {
          setSearchResults(data || [])
        }
      } catch (error) {
        toast({ title: "Search Error", description: "Failed to fetch donors" })
      } finally {
        setSearchLoading(false)
      }
    }, 300),
    [],
  )

  // Handle search term changes
  useEffect(() => {
    debouncedSearch(searchTerm)
  }, [searchTerm, debouncedSearch])

  const handleCreatePartner = async (name: string, index: number) => {
    if (isCreatingPartner) return // Prevent multiple clicks
    setIsCreatingPartner(true)
    try {
      const { data: newPartner, error } = await supabase
        .from("donors")
        .insert({ name })
        .select()
        .single()

      if (error) throw error

      // Update search results with new partner
      setSearchResults((prevResults) => [...prevResults, newPartner])
      
      // Immediately select the new partner for this entry
      handleSelectDonor(index, newPartner)
      
      // Clear search term since we've selected the partner
      setSearchTerm("")
      
      return newPartner.id
    } catch (error) {
      toast({ 
        title: "Error creating partner", 
        description: error.message, 
        variant: "destructive" 
      })
    } finally {
      setIsCreatingPartner(false)
    }
  }

  const handleSelectDonor = (index: number, donor: Partner) => {
    const newEntries = [...donorEntries]
    newEntries[index] = { ...newEntries[index], donorId: donor.id, donorName: donor.name }
    setDonorEntries(newEntries)
    setSearchTerm("")
    setSearchResults([])
  }

  const handleAddDonorEntry = () => {
    setDonorEntries([...donorEntries, { donorId: "", amount: "", donorName: "" }])
  }

  const handleRemoveDonorEntry = (index: number) => {
    setDonorEntries(donorEntries.filter((_, i) => i !== index))
  }

  const validateStep1 = () => {
    const total = Number.parseFloat(totalAmount)
    return !isNaN(total) && total > 0
  }

  const validateStep2 = () => {
    const sum = donorEntries.reduce((acc, entry) => {
      const amount = Number.parseFloat(entry.amount)
      return acc + (isNaN(amount) ? 0 : amount)
    }, 0)

    return (
      Math.abs(sum - Number.parseFloat(totalAmount)) <= 0.01 &&
      donorEntries.every(
        (entry) =>
          String(entry.donorId).trim() !== "" &&
          !isNaN(Number.parseFloat(entry.amount)) &&
          Number.parseFloat(entry.amount) > 0,
      )
    )
  }

  const handleSubmit = async () => {
    setLoading(true)
    try {
      const entries = await Promise.all(
        donorEntries.map(async (entry) => {
          const amount = Number.parseFloat(entry.amount)
          return {
            donor_id: entry.donorId,
            amount,
            missionary_id: missionaryId,
            date: new Date().toISOString(),
            source: "offline",
            status: "completed",
          }
        }),
      )

      const { error } = await supabase.from("donor_donations").insert(entries)

      if (error) throw error

      setSuccess(true)
      setTimeout(() => {
        setSuccess(false)
        setStep(1)
        setTotalAmount("")
        setDonorEntries([{ donorId: "", amount: "" }])
      }, 2000)

      toast({
        title: "Remittance submitted successfully!",
        description: "The donations have been recorded.",
      })
    } catch (error) {
      toast({
        title: "Submission failed",
        description: error.message,
        variant: "destructive",
      })
    } finally {
      setLoading(false)
    }
  }

  return (
    <Card className="w-full max-w-2xl mx-auto">
      <CardHeader>
        <CardTitle className="text-2xl font-bold text-center">Manual Remittance</CardTitle>
      </CardHeader>
      <CardContent className="space-y-6">
        <Progress value={step === 1 ? 50 : 100} className="w-full" />

        <p className="text-center text-muted-foreground">
          {step === 1 ? "Enter total amount" : "Distribute donations to partners"}
        </p>

        <div className="relative">
          {success && (
            <div className="absolute inset-0 bg-background/90 flex items-center justify-center rounded-lg z-10">
              <div className="text-center space-y-4">
                <CheckCircle className="h-12 w-12 text-green-500 mx-auto animate-bounce" />
                <p className="font-semibold">Remittance recorded successfully!</p>
              </div>
            </div>
          )}

          {step === 1 && (
            <div className="space-y-6">
              <div className="space-y-2">
                <Label htmlFor="totalAmount" className="text-lg">
                  Total Amount
                </Label>
                <Input
                  id="totalAmount"
                  type="number"
                  value={totalAmount}
                  onChange={(e) => setTotalAmount(e.target.value)}
                  placeholder="0.00"
                  className="text-2xl h-16 text-center"
                />
              </div>

              <Button size="lg" className="w-full" onClick={() => setStep(2)} disabled={!validateStep1()}>
                Next: Assign Partners
              </Button>
            </div>
          )}

          {step === 2 && (
            <div className="space-y-6">
              {donorEntries.map((entry, index) => (
                <Card key={index} className="p-4 border-2 border-muted">
                  <div className="space-y-4">
                    <div className="flex justify-between items-center">
                      <Label className="text-lg font-medium">Partner {index + 1}</Label>
                      {index > 0 && (
                        <Button 
                          variant="ghost" 
                          size="sm" 
                          onClick={() => handleRemoveDonorEntry(index)}
                          className="hover:bg-destructive/10 hover:text-destructive"
                        >
                          <Trash className="h-4 w-4" />
                        </Button>
                      )}
                    </div>

                    <div className="relative">
                      <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
                      <Input
                        type="text"
                        placeholder="Search for a partner..."
                        value={entry.donorName || searchTerm}
                        onChange={(e) => {
                          if (!entry.donorId) {
                            setSearchTerm(e.target.value)
                          }
                        }}
                        disabled={!!entry.donorId}
                        className="pl-8 transition-all focus:ring-2 focus:ring-primary/20"
                      />
                    </div>

                    {searchTerm.trim() && !entry.donorId && (
                      <Card className="mt-2 border-2 border-muted">
                        <CardContent className="p-2">
                          {searchLoading ? (
                            <div className="flex items-center justify-center p-4 text-muted-foreground">
                              <Loader2 className="mr-2 h-4 w-4 animate-spin" /> 
                              Searching...
                            </div>
                          ) : searchResults.length > 0 ? (
                            <ul className="space-y-1 max-h-48 overflow-y-auto">
                              {searchResults.map((partner) => (
                                <li
                                  key={partner.id}
                                  className="p-2 hover:bg-accent rounded-md cursor-pointer transition-colors flex items-center"
                                  onClick={() => handleSelectDonor(index, partner)}
                                >
                                  <span className="flex-1">{partner.name}</span>
                                  <CheckCircle className="h-4 w-4 text-muted-foreground opacity-0 group-hover:opacity-100" />
                                </li>
                              ))}
                            </ul>
                          ) : (
                            <div className="p-4 text-center text-muted-foreground">
                              No partners found
                            </div>
                          )}
                        </CardContent>
                      </Card>
                    )}

                    {!entry.donorId && (
                      <Button
                        type="button"
                        variant="outline"
                        size="sm"
                        onClick={async () => {
                          await handleCreatePartner(searchTerm, index)
                        }}
                        disabled={!searchTerm.trim() || isCreatingPartner}
                        className="w-full"
                      >
                        {isCreatingPartner ? (
                          <>
                            <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                            Creating Partner...
                          </>
                        ) : (
                          <>
                            <UserPlus className="mr-2 h-4 w-4" /> 
                            Create New Partner
                          </>
                        )}
                      </Button>
                    )}

                    <div className="space-y-2">
                      <Label htmlFor={`amount-${index}`}>Amount</Label>
                      <div className="relative">
                        <span className="absolute left-3 top-2.5 text-muted-foreground">₱</span>
                        <Input
                          id={`amount-${index}`}
                          type="number"
                          value={entry.amount}
                          onChange={(e) => {
                            const newEntries = [...donorEntries]
                            newEntries[index].amount = e.target.value
                            setDonorEntries(newEntries)
                          }}
                          placeholder="0.00"
                          className="pl-8"
                        />
                      </div>
                    </div>
                  </div>
                </Card>
              ))}

              <div className="flex flex-col gap-4 sm:flex-row">
                <Button 
                  variant="outline" 
                  className="flex-1" 
                  onClick={handleAddDonorEntry}
                >
                  <Plus className="mr-2 h-4 w-4" /> Add Partner
                </Button>

                <Button 
                  size="lg" 
                  className="flex-1" 
                  onClick={handleSubmit} 
                  disabled={!validateStep2() || loading}
                >
                  {loading ? (
                    <>
                      <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                      Processing...
                    </>
                  ) : (
                    "Submit Remittance"
                  )}
                </Button>
              </div>

              <Button 
                variant="ghost" 
                onClick={() => setStep(1)} 
                className="w-full"
              >
                <ArrowLeft className="mr-2 h-4 w-4" /> Back to Total Amount
              </Button>
            </div>
          )}
        </div>

        {step === 2 && (
          <Card className="bg-muted/50 border-2 border-muted">
            <CardContent className="p-4">
              <div className="space-y-2">
                <div className="flex justify-between font-medium">
                  <span>Total Entered:</span>
                  <span className="text-primary">
                    ₱{donorEntries
                      .reduce((acc, entry) => acc + (Number.parseFloat(entry.amount) || 0), 0)
                      .toLocaleString()}
                  </span>
                </div>
                <div className="flex justify-between text-muted-foreground">
                  <span>Declared Total:</span>
                  <span>₱{Number.parseFloat(totalAmount).toLocaleString()}</span>
                </div>
              </div>
            </CardContent>
          </Card>
        )}
      </CardContent>
    </Card>
  )
}

function debounce(func: (...args: any[]) => void, delay: number) {
  let timeoutId: NodeJS.Timeout
  return (...args: any[]) => {
    clearTimeout(timeoutId)
    timeoutId = setTimeout(() => func(...args), delay)
  }
}

