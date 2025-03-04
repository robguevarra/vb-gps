/**
 * Storage Utility Functions
 * 
 * A collection of utility functions for safely interacting with localStorage.
 * These functions provide error handling, type safety, and performance optimizations.
 */

/**
 * Safely stores data in localStorage with error handling
 * 
 * @param key - The key to store the data under
 * @param data - The data to store (will be JSON stringified)
 * @returns boolean indicating success or failure
 */
export function safelyStoreData(key: string, data: any): boolean {
  try {
    const serialized = JSON.stringify(data);
    localStorage.setItem(key, serialized);
    return true;
  } catch (err) {
    console.error(`Error storing data for key ${key}:`, err);
    return false;
  }
}

/**
 * Safely retrieves data from localStorage with error handling and type safety
 * 
 * @param key - The key to retrieve data from
 * @param defaultValue - The default value to return if the key doesn't exist or there's an error
 * @returns The parsed data with the specified type, or the default value
 */
export function safelyGetData<T>(key: string, defaultValue: T): T {
  try {
    const serialized = localStorage.getItem(key);
    if (serialized === null) return defaultValue;
    return JSON.parse(serialized) as T;
  } catch (err) {
    console.error(`Error retrieving data for key ${key}:`, err);
    return defaultValue;
  }
}

/**
 * Safely removes data from localStorage with error handling
 * 
 * @param key - The key to remove
 * @returns boolean indicating success or failure
 */
export function safelyRemoveData(key: string): boolean {
  try {
    localStorage.removeItem(key);
    return true;
  } catch (err) {
    console.error(`Error removing data for key ${key}:`, err);
    return false;
  }
}

/**
 * Checks if localStorage is available in the current environment
 * 
 * @returns boolean indicating if localStorage is available
 */
export function isStorageAvailable(): boolean {
  try {
    const testKey = '__storage_test__';
    localStorage.setItem(testKey, testKey);
    localStorage.removeItem(testKey);
    return true;
  } catch (e) {
    return false;
  }
}

/**
 * Gets all keys in localStorage that match a prefix
 * 
 * @param prefix - The prefix to match
 * @returns Array of matching keys
 */
export function getKeysByPrefix(prefix: string): string[] {
  try {
    const keys: string[] = [];
    for (let i = 0; i < localStorage.length; i++) {
      const key = localStorage.key(i);
      if (key && key.startsWith(prefix)) {
        keys.push(key);
      }
    }
    return keys;
  } catch (err) {
    console.error(`Error getting keys with prefix ${prefix}:`, err);
    return [];
  }
}

/**
 * Clears all localStorage items that match a prefix
 * 
 * @param prefix - The prefix to match
 * @returns boolean indicating success or failure
 */
export function clearByPrefix(prefix: string): boolean {
  try {
    const keys = getKeysByPrefix(prefix);
    keys.forEach(key => localStorage.removeItem(key));
    return true;
  } catch (err) {
    console.error(`Error clearing keys with prefix ${prefix}:`, err);
    return false;
  }
} 