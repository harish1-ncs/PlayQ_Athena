/**
 * PlayQ Example: web.openBrowser
 *
 * Purpose: Navigate to a URL and initialize the page context.
 * Steps:
 * - Call web.openBrowser with page and url
 * - Proceed with actions/assertions
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/forms';

test('Open browser to forms page', async ({ page }) => {
  await web.openBrowser(page, url, { screenshot: true, screenshotText: 'Opened LetCode forms' });
  await web.waitForUrl(page, '/forms', { match: 'contains' });
  expect(page.url()).toContain('/forms');
});
