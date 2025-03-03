"use client";

import { useState } from "react";
import { usePaymentWizardStore } from "@/stores/paymentWizardStore";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { X, Loader2, User, Mail, Phone, Save } from "lucide-react";
import { motion } from "framer-motion";
import { createClient } from "@/utils/supabase/client";
import { z } from "zod";

// Validation schema for new donor
const donorSchema = z.object({
  name: z.string().min(2, "Name must be at least 2 characters"),
  email: z.string().email("Invalid email address").optional().or(z.literal("")),
  phone: z.string().optional().or(z.literal(""))
});

type DonorFormData = z.infer<typeof donorSchema>;

interface DonorCreationFormProps {
  onSuccess?: (donor: { id: string; name: string; email?: string; phone?: string }) => void;
  onCancel?: () => void;
}

/**
 * DonorCreationForm Component
 * 
 * Form for creating a new donor when one can't be found in the search results.
 * This component handles validation, submission, and error handling.
 */
export function DonorCreationForm({ onSuccess, onCancel }: DonorCreationFormProps) {
  const { setIsNewDonorFormOpen } = usePaymentWizardStore();
  
  const [formData, setFormData] = useState<DonorFormData>({
    name: "",
    email: "",
    phone: ""
  });
  
  const [errors, setErrors] = useState<Partial<Record<keyof DonorFormData, string>>>({});
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitError, setSubmitError] = useState<string | null>(null);
  
  const handleChange = (field: keyof DonorFormData, value: string) => {
    setFormData(prev => ({ ...prev, [field]: value }));
    
    // Clear error when user types
    if (errors[field]) {
      setErrors(prev => {
        const newErrors = { ...prev };
        delete newErrors[field];
        return newErrors;
      });
    }
  };
  
  const validateForm = (): boolean => {
    try {
      donorSchema.parse(formData);
      setErrors({});
      return true;
    } catch (err) {
      if (err instanceof z.ZodError) {
        const newErrors: Partial<Record<keyof DonorFormData, string>> = {};
        err.errors.forEach(error => {
          const path = error.path[0] as keyof DonorFormData;
          newErrors[path] = error.message;
        });
        setErrors(newErrors);
      }
      return false;
    }
  };
  
  const handleSubmit = async () => {
    setSubmitError(null);
    
    if (!validateForm()) {
      return;
    }
    
    setIsSubmitting(true);
    
    try {
      const supabase = createClient();
      
      // Create new donor in the database
      const { data, error } = await supabase
        .from("donors")
        .insert({
          name: formData.name,
          email: formData.email || null,
          phone: formData.phone || null
        })
        .select("id, name, email, phone")
        .single();
      
      if (error) {
        throw error;
      }
      
      // Call success callback with the new donor
      if (onSuccess && data) {
        onSuccess(data);
      }
      
      // Close the form
      setIsNewDonorFormOpen(false);
      
    } catch (err) {
      console.error("Error creating donor:", err);
      setSubmitError(err instanceof Error ? err.message : "Failed to create donor");
    } finally {
      setIsSubmitting(false);
    }
  };
  
  const handleCancel = () => {
    if (onCancel) {
      onCancel();
    }
    setIsNewDonorFormOpen(false);
  };
  
  return (
    <motion.div
      initial={{ opacity: 0, scale: 0.95 }}
      animate={{ opacity: 1, scale: 1 }}
      exit={{ opacity: 0, scale: 0.95 }}
      transition={{ duration: 0.2 }}
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4"
    >
      <Card className="w-full max-w-md">
        <CardHeader className="flex flex-row items-center justify-between">
          <CardTitle className="text-xl font-semibold">Add New Donor</CardTitle>
          <Button
            variant="ghost"
            size="sm"
            className="h-8 w-8 p-0"
            onClick={handleCancel}
          >
            <X className="h-4 w-4" />
          </Button>
        </CardHeader>
        <CardContent className="space-y-4">
          {/* Name field */}
          <div>
            <Label htmlFor="donor-name" className="required">Name</Label>
            <div className="relative mt-1">
              <User className="absolute left-2 top-2.5 h-4 w-4 text-gray-400" />
              <Input
                id="donor-name"
                placeholder="Enter donor name"
                className="pl-8"
                value={formData.name}
                onChange={(e) => handleChange("name", e.target.value)}
              />
            </div>
            {errors.name && (
              <p className="text-sm text-red-500 mt-1">{errors.name}</p>
            )}
          </div>
          
          {/* Email field */}
          <div>
            <Label htmlFor="donor-email">Email (optional)</Label>
            <div className="relative mt-1">
              <Mail className="absolute left-2 top-2.5 h-4 w-4 text-gray-400" />
              <Input
                id="donor-email"
                type="email"
                placeholder="Enter donor email"
                className="pl-8"
                value={formData.email}
                onChange={(e) => handleChange("email", e.target.value)}
              />
            </div>
            {errors.email && (
              <p className="text-sm text-red-500 mt-1">{errors.email}</p>
            )}
          </div>
          
          {/* Phone field */}
          <div>
            <Label htmlFor="donor-phone">Phone (optional)</Label>
            <div className="relative mt-1">
              <Phone className="absolute left-2 top-2.5 h-4 w-4 text-gray-400" />
              <Input
                id="donor-phone"
                placeholder="Enter donor phone"
                className="pl-8"
                value={formData.phone}
                onChange={(e) => handleChange("phone", e.target.value)}
              />
            </div>
            {errors.phone && (
              <p className="text-sm text-red-500 mt-1">{errors.phone}</p>
            )}
          </div>
          
          {/* Submit error */}
          {submitError && (
            <p className="text-sm text-red-500 mt-1">{submitError}</p>
          )}
        </CardContent>
        <CardFooter className="flex justify-between">
          <Button
            variant="outline"
            onClick={handleCancel}
          >
            Cancel
          </Button>
          <Button
            onClick={handleSubmit}
            disabled={isSubmitting}
            className="bg-primary text-primary-foreground"
          >
            {isSubmitting ? (
              <>
                <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                Creating...
              </>
            ) : (
              <>
                <Save className="mr-2 h-4 w-4" />
                Create Donor
              </>
            )}
          </Button>
        </CardFooter>
      </Card>
    </motion.div>
  );
} 