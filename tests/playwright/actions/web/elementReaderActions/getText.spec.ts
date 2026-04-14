/**
 * PlayQ Example: web.getText
 *
 * Purpose: Read the inner text of an element.
 * Page: LetCode → /elements
 * PatternIQ: Provide { pattern, fieldType } to resolve targets.
 * Steps:
 * - Open page
 * - Resolve element (e.g., button)
 * - Read text and assert
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/elements';

test('Read text from Search button', async ({ page }) => {
  await web.openBrowser(page, url);
  const text = await web.getText(page, 'Search', { fieldType: 'button', pattern: 'letcodesamples' });
  expect(text.trim()).toBe('Search');
});
