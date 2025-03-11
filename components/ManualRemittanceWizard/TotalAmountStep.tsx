"use client"

import React from "react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"

interface TotalAmountStepProps {
  totalAmount: string
  setTotalAmount: (amount: string) => void
  onNext: () => void
  isValid: boolean
}

export function TotalAmountStep({ totalAmount, setTotalAmount, onNext, isValid }: TotalAmountStepProps) {
  return (
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

      <Button size="lg" className="w-full" onClick={onNext} disabled={!isValid}>
        Next: Assign Partners
      </Button>
    </div>
  )
}