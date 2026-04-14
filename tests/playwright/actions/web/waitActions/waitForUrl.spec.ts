/**
 * PlayQ Example: web.waitForUrl
 *
 * Purpose: Wait until the current page URL matches expected value/pattern.
 * PatternIQ: Not applicable.
 * Steps:
 * - Open page or navigate
 * - Wait for URL
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const base = 'https://letcode.in';

test('Wait for URL to contain /waits', async ({ page }) => {
  await web.openBrowser(page, base + '/waits');
  await web.waitForUrl(page, '/waits', { match: 'contains' });
  expect(page.url()).toContain('/waits');
});
