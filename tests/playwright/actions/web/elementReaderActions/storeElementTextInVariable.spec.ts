/**
 * Example: web.storeElementTextInVariable
 *
 * Purpose: Stores an element's text into a PlayQ variable.
 * Site: letcode.in/elements
 */
import { test, expect } from '@playwright/test';
import { web, vars } from '@playq/core';

const url = 'https://letcode.in/elements';

test('Store Search button text in variable', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.storeElementTextInVariable(page, 'Search', 'searchButtonText', { trim: true, normalizeWhitespace: true, fieldType: 'button', pattern: 'letcodesamples' });
  const stored = (vars as any).getValue?.('searchButtonText') ?? (vars as any).get?.('searchButtonText');
  expect(stored).toBe('Search');
});
