/**
 * Example: web.getAttribute
 *
 * Purpose: Reads a specific attribute from an element.
 * Site: letcode.in/elements
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/elements';

test('Read placeholder attribute from username input', async ({ page }) => {
  await web.openBrowser(page, url);
  const placeholder = await web.getAttribute(page, 'username', 'placeholder', { fieldType: 'input', pattern: 'letcodesamples' });
  expect(placeholder).toBe('Enter your git user name eg., ortonikc');
});
