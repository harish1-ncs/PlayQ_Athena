/**
 * Example: web.navigateByPath
 *
 * Purpose: Navigates to a relative path from the current origin/base URL.
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const base = 'https://letcode.in';

test('Navigate by relative path', async ({ page }) => {
  await web.openBrowser(page, base);
  await web.navigateByPath(page, '/forms', { screenshot: true, screenshotText: 'Navigated by path' });
  await web.waitForUrl(page, '/forms', { match: 'contains' });
  expect(page.url()).toContain('/forms');
});
