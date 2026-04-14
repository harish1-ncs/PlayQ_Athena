/**
 * Example: web.takeFullScreenshot
 *
 * Purpose: Captures a full-page screenshot using defaults.
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in';

test('Take full page screenshot', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.takeFullScreenshot(page, { screenshotText: 'Full page' });
});
