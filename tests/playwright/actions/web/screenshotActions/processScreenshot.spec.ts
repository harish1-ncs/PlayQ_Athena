/**
 * Example: web.processScreenshot
 *
 * Purpose: Processes screenshot capture with custom text and options.
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in';

test('Process screenshot manually', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.processScreenshot(page, true, 'Manual screenshot after load', true);
});
