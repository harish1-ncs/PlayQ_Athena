/**
 * PlayQ Example: web.type
 *
 * Purpose: Type into an input using PatternIQ-resolved locator or raw selector.
 * Page: See 'url' constant.
 * PatternIQ: Provide { pattern, fieldType: 'input' } to resolve inputs.
 * Steps:
 * - Open page
 * - Resolve input field
 * - Type text and verify
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/edit';

test('Keyboard: type into Full Name', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.type(page, 'Enter your full Name', 'John Doe', { pattern: 'letcodesamples' });
});
