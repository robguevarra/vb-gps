/**
 * Validates an email address
 * @param email - Email address to validate
 * @returns True if the email is valid, false otherwise
 */
export const isValidEmail = (email: string): boolean => {
  if (!email) return true; // Empty email is considered valid (it's optional)
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

/**
 * Utility function to debounce function calls
 * @param func - Function to debounce
 * @param delay - Delay in milliseconds
 */
export function debounce(func: (...args: any[]) => void, delay: number) {
  let timeoutId: NodeJS.Timeout
  return (...args: any[]) => {
    clearTimeout(timeoutId)
    timeoutId = setTimeout(() => func(...args), delay)
  }
}