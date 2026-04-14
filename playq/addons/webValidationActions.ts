/**
 * @file webValidationActions.ts
 *
 * Generic web validation actions for PlayQ framework.
 * Provides utilities for verifying UI states, ordering, and other assertions.
 *
 * Authors: PlayQ Team
 * Version: v1.0.0
 */

import type { Page, Locator } from "playwright";

/**
 * Web: Verify List in Alphabetical Order
 *
 * Verifies that a list of elements is sorted in alphabetical order (case-insensitive).
 * Retrieves text from all matching elements and validates ordering.
 *
 * @param page - Playwright Page instance
 * @param selector - CSS selector or Locator for the list items (e.g., 'ul.gap-2.pl-5 li button')
 * @param options - Optional configuration object
 *   - caseSensitive: [boolean] Whether to perform case-sensitive comparison. Default: false
 *   - logResults: [boolean] Whether to log detailed results. Default: true
 * @returns Object with verification results: { isOrdered: boolean, items: string[], sortedItems: string[] }
 * @throws Error if page is not initialized or selector is invalid
 *
 * @example
 * const result = await verifyListInAlphabeticalOrder(page, 'ul.gap-2.pl-5 li button');
 * if (result.isOrdered) {
 *   console.log('✓ List is in alphabetical order');
 * }
 */
export async function verifyListInAlphabeticalOrder(
  page: Page,
  selector: string | Locator,
  options?: Record<string, any>
) {
  if (!page) throw new Error("Page not initialized");

  const {
    caseSensitive = false,
    logResults = true,
  } = options || {};

  // Resolve locator
  const locator = typeof selector === 'string' 
    ? page.locator(selector)
    : selector;

  // Get all text contents
  const allItems = await locator.allTextContents();
  const trimmedItems = allItems.map(item => item.trim());

  // Sort items
  const sortedItems = [...trimmedItems].sort((a, b) => {
    if (caseSensitive) {
      return a.localeCompare(b);
    }
    return a.localeCompare(b, undefined, { sensitivity: 'base' });
  });

  // Check if already sorted
  const isOrdered = JSON.stringify(trimmedItems) === JSON.stringify(sortedItems);

  // Log results if enabled
  if (logResults) {
    if (isOrdered) {
      console.log(`✓ All items are in alphabetical order`);
    } else {
      console.log(`✗ Items are NOT in alphabetical order`);
      console.log(`Current order:`, trimmedItems);
      console.log(`Expected order:`, sortedItems);
    }
  }

  return {
    isOrdered,
    items: trimmedItems,
    sortedItems,
  };
}

/**
 * Web: Verify Item Exists in List
 *
 * Verifies that a specific item exists in a list of elements.
 *
 * @param page - Playwright Page instance
 * @param selector - CSS selector or Locator for the list items
 * @param searchText - Text to search for in the list
 * @param options - Optional configuration object
 *   - partialMatch: [boolean] Whether to use partial text matching. Default: false
 *   - caseSensitive: [boolean] Whether to perform case-sensitive search. Default: false
 * @returns Object with search results: { exists: boolean, items: string[], foundItem: string | null }
 * @throws Error if page is not initialized
 *
 * @example
 * const result = await verifyItemExistsInList(page, 'ul.gap-2.pl-5 li button', 'MyProject');
 * if (result.exists) {
 *   console.log(`✓ Item found: ${result.foundItem}`);
 * }
 */
export async function verifyItemExistsInList(
  page: Page,
  selector: string | Locator,
  searchText: string,
  options?: Record<string, any>
) {
  if (!page) throw new Error("Page not initialized");

  const {
    partialMatch = false,
    caseSensitive = false,
  } = options || {};

  // Resolve locator
  const locator = typeof selector === 'string' 
    ? page.locator(selector)
    : selector;

  // Get all text contents
  const allItems = await locator.allTextContents();
  const trimmedItems = allItems.map(item => item.trim());

  // Search for item
  let foundItem: string | null = null;
  const exists = trimmedItems.some(item => {
    const itemToCompare = caseSensitive ? item : item.toLowerCase();
    const searchToCompare = caseSensitive ? searchText : searchText.toLowerCase();
    
    const matches = partialMatch 
      ? itemToCompare.includes(searchToCompare)
      : itemToCompare === searchToCompare;
    
    if (matches) {
      foundItem = item;
      return true;
    }
    return false;
  });

  return {
    exists,
    items: trimmedItems,
    foundItem,
  };
}
