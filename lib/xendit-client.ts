/**
 * Client-side Xendit utilities for card tokenization
 * 
 * This module provides functions for securely tokenizing card details
 * using Xendit.js on the client side.
 */

// Define types for Xendit.js
declare global {
  interface Window {
    Xendit: {
      setPublishableKey: (key: string) => void;
      card: {
        validateCardNumber: (cardNumber: string) => boolean;
        validateExpiry: (month: string, year: string) => boolean;
        validateCvn: (cvn: string) => boolean;
        createToken: (
          data: {
            card_number: string;
            card_exp_month: string;
            card_exp_year: string;
            card_cvn: string;
            is_multiple_use?: boolean;
          },
          callback: (err: any, response: any) => void
        ) => void;
      };
    };
  }
}

/**
 * Initializes Xendit.js with the publishable key
 * 
 * @param publishableKey The Xendit publishable key
 */
export const initializeXendit = (publishableKey: string): void => {
  if (typeof window !== 'undefined' && window.Xendit) {
    window.Xendit.setPublishableKey(publishableKey);
  } else {
    console.error('Xendit.js is not loaded or not available');
  }
};

/**
 * Validates card details using Xendit.js
 * 
 * @param cardNumber The card number
 * @param expiryMonth The expiry month (MM)
 * @param expiryYear The expiry year (YY)
 * @param cvn The card verification number
 * @returns An object with validation results
 */
export const validateCardDetails = (
  cardNumber: string,
  expiryMonth: string,
  expiryYear: string,
  cvn: string
): { isValid: boolean; errors: Record<string, string> } => {
  if (typeof window === 'undefined' || !window.Xendit) {
    return { isValid: false, errors: { general: 'Xendit.js is not loaded' } };
  }

  const errors: Record<string, string> = {};
  
  // Clean up card number (remove spaces)
  const cleanCardNumber = cardNumber.replace(/\s+/g, '');
  
  // Validate card number
  if (!window.Xendit.card.validateCardNumber(cleanCardNumber)) {
    errors.cardNumber = 'Invalid card number';
  }
  
  // Validate expiry
  if (!window.Xendit.card.validateExpiry(expiryMonth, expiryYear)) {
    errors.expiry = 'Invalid expiry date';
  }
  
  // Validate CVN
  if (!window.Xendit.card.validateCvn(cvn)) {
    errors.cvn = 'Invalid CVN';
  }
  
  return {
    isValid: Object.keys(errors).length === 0,
    errors,
  };
};

/**
 * Tokenizes card details using Xendit.js
 * 
 * @param cardNumber The card number
 * @param expiryMonth The expiry month (MM)
 * @param expiryYear The expiry year (YY)
 * @param cvn The card verification number
 * @param isMultipleUse Whether the token should be reusable
 * @returns A promise that resolves to the token response
 */
export const tokenizeCard = (
  cardNumber: string,
  expiryMonth: string,
  expiryYear: string,
  cvn: string,
  isMultipleUse: boolean = false
): Promise<{ id: string; status: string }> => {
  return new Promise((resolve, reject) => {
    if (typeof window === 'undefined' || !window.Xendit) {
      reject(new Error('Xendit.js is not loaded'));
      return;
    }
    
    // Clean up card number (remove spaces)
    const cleanCardNumber = cardNumber.replace(/\s+/g, '');
    
    // Create token
    window.Xendit.card.createToken({
      card_number: cleanCardNumber,
      card_exp_month: expiryMonth,
      card_exp_year: expiryYear,
      card_cvn: cvn,
      is_multiple_use: isMultipleUse,
    }, (err, response) => {
      if (err) {
        reject(err);
      } else {
        resolve(response);
      }
    });
  });
};

/**
 * Parses an expiry date string in MM/YY format
 * 
 * @param expiryDate The expiry date string (MM/YY)
 * @returns An object with month and year
 */
export const parseExpiryDate = (expiryDate: string): { month: string; year: string } => {
  const [month, year] = expiryDate.split('/');
  return { month, year };
};

/**
 * Loads the Xendit.js script dynamically
 * 
 * @returns A promise that resolves when the script is loaded
 */
export const loadXenditJs = (): Promise<void> => {
  return new Promise((resolve, reject) => {
    if (typeof window === 'undefined') {
      reject(new Error('Cannot load Xendit.js in a non-browser environment'));
      return;
    }
    
    // Check if already loaded
    if (window.Xendit) {
      resolve();
      return;
    }
    
    const script = document.createElement('script');
    script.src = 'https://js.xendit.co/v1/xendit.min.js';
    script.async = true;
    
    script.onload = () => resolve();
    script.onerror = () => reject(new Error('Failed to load Xendit.js'));
    
    document.head.appendChild(script);
  });
}; 