/**
 * Example: web.getHtml
 *
 * Purpose: Reads the inner HTML of an element.
 * Site: letcode.in/elements
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/elements';

test('Read inner HTML from Search button', async ({ page }) => {
  await web.openBrowser(page, url);
  const html = await web.getHtml(page, 'Search', { fieldType: 'button', pattern: 'letcodesamples' });
  expect(typeof html).toBe('string');
  expect(html.length).toBeGreaterThan(0);
  expect(html).toContain('Search');
});
