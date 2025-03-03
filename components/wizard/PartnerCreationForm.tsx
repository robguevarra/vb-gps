"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { X, Loader2, User, Mail, Phone, Save } from "lucide-react";
import { motion } from "framer-motion";
import { z } from "zod";
import { Partner } from "@/stores/paymentWizardStore";

// Validation schema for new partner
const partnerSchema = z.object({
  name: z.string().min(2, "Name must be at least 2 characters"),
  email: z.string().email("Invalid email address").optional().or(z.literal("")),
  phone: z.string().optional().or(z.literal(""))
});

type PartnerFormData = z.infer<typeof partnerSchema>;

interface PartnerCreationFormProps {
  donorId: string;
  donorName: string;
  onSuccess?: (partner: Omit<Partner, 'id' | 'donorId'>) => void;
  onCancel?: () => void;
}

/**
 * PartnerCreationForm Component
 * 
 * Form for adding a partner to a donor.
 * This component handles validation, submission, and error handling.
 */
export function PartnerCreationForm({ donorId, donorName, onSuccess, onCancel }: PartnerCreationFormProps) {
  const [formData, setFormData] = useState<PartnerFormData>({
    name: "",
    email: "",
    phone: ""
  });
  
  const [errors, setErrors] = useState<Partial<Record<keyof PartnerFormData, string>>>({});
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitError, setSubmitError] = useState<string | null>(null);
  
  const handleChange = (field: keyof PartnerFormData, value: string) => {
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
      partnerSchema.parse(formData);
      setErrors({});
      return true;
    } catch (err) {
      if (err instanceof z.ZodError) {
        const newErrors: Partial<Record<keyof PartnerFormData, string>> = {};
        err.errors.forEach(error => {
          const path = error.path[0] as keyof PartnerFormData;
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
      // Use the server API endpoint
      const response = await fetch('/api/partners/create', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          donorId,
          name: formData.name,
          email: formData.email || null,
          phone: formData.phone || null
        }),
      });
      
      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to create partner');
      }
      
      const data = await response.json();
      
      // Call success callback with the new partner data
      if (onSuccess) {
        onSuccess({
          name: data.name,
          email: data.email || undefined,
          phone: data.phone || undefined
        });
      }
      
    } catch (err) {
      console.error("Error creating partner:", err);
      setSubmitError(err instanceof Error ? err.message : "Failed to create partner");
    } finally {
      setIsSubmitting(false);
      // Close the form if no error
      if (!submitError && onCancel) {
        onCancel();
      }
    }
  };
  
  const handleCancel = () => {
    if (onCancel) {
      onCancel();
    }
  };
  
  return (
    <motion.div
      initial={{ opacity: 0, scale: 0.95 }}
      animate={{ opacity: 1, scale: 1 }}
      exit={{ opacity: 0, scale: 0.95 }}
      transition={{ duration: 0.2 }}
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-3 sm:p-4"
    >
      <Card className="w-full max-w-md overflow-hidden">
        <CardHeader className="flex flex-row items-center justify-between px-4 py-3 sm:px-6 sm:py-4">
          <CardTitle className="text-base sm:text-xl font-semibold truncate pr-2">
            Add Partner for {donorName}
          </CardTitle>
          <Button
            variant="ghost"
            size="sm"
            className="h-7 w-7 sm:h-8 sm:w-8 p-0 flex-shrink-0"
            onClick={handleCancel}
          >
            <X className="h-3 w-3 sm:h-4 sm:w-4" />
          </Button>
        </CardHeader>
        <CardContent className="space-y-3 sm:space-y-4 px-4 sm:px-6">
          {/* Name field */}
          <div>
            <Label htmlFor="partner-name" className="required text-xs sm:text-sm">Name</Label>
            <div className="relative mt-1">
              <User className="absolute left-2 top-2.5 h-4 w-4 text-gray-400" />
              <Input
                id="partner-name"
                placeholder="Enter partner name"
                className="pl-8 text-sm"
                value={formData.name}
                onChange={(e) => handleChange("name", e.target.value)}
              />
            </div>
            {errors.name && (
              <p className="text-xs sm:text-sm text-red-500 mt-1">{errors.name}</p>
            )}
          </div>
          
          {/* Email field */}
          <div>
            <Label htmlFor="partner-email" className="text-xs sm:text-sm">Email (optional)</Label>
            <div className="relative mt-1">
              <Mail className="absolute left-2 top-2.5 h-4 w-4 text-gray-400" />
              <Input
                id="partner-email"
                type="email"
                placeholder="Enter partner email"
                className="pl-8 text-sm"
                value={formData.email}
                onChange={(e) => handleChange("email", e.target.value)}
              />
            </div>
            {errors.email && (
              <p className="text-xs sm:text-sm text-red-500 mt-1">{errors.email}</p>
            )}
          </div>
          
          {/* Phone field */}
          <div>
            <Label htmlFor="partner-phone" className="text-xs sm:text-sm">Phone (optional)</Label>
            <div className="relative mt-1">
              <Phone className="absolute left-2 top-2.5 h-4 w-4 text-gray-400" />
              <Input
                id="partner-phone"
                placeholder="Enter partner phone"
                className="pl-8 text-sm"
                value={formData.phone}
                onChange={(e) => handleChange("phone", e.target.value)}
              />
            </div>
            {errors.phone && (
              <p className="text-xs sm:text-sm text-red-500 mt-1">{errors.phone}</p>
            )}
          </div>
          
          {/* Submit error */}
          {submitError && (
            <p className="text-xs sm:text-sm text-red-500 mt-1">{submitError}</p>
          )}
        </CardContent>
        <CardFooter className="flex justify-between px-4 py-3 sm:px-6 sm:py-4">
          <Button
            variant="outline"
            onClick={handleCancel}
            className="text-xs sm:text-sm"
          >
            Cancel
          </Button>
          <Button
            onClick={handleSubmit}
            disabled={isSubmitting}
            className="bg-primary text-primary-foreground text-xs sm:text-sm"
          >
            {isSubmitting ? (
              <>
                <Loader2 className="mr-1 sm:mr-2 h-3 w-3 sm:h-4 sm:w-4 animate-spin" />
                Adding...
              </>
            ) : (
              <>
                <Save className="mr-1 sm:mr-2 h-3 w-3 sm:h-4 sm:w-4" />
                Add Partner
              </>
            )}
          </Button>
        </CardFooter>
      </Card>
    </motion.div>
  );
} 