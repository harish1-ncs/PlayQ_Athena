/**
 * PlayQ Example: web.takeScreenshot
 *
 * Purpose: Capture a screenshot of the current page.
 * Steps:
 * - Open page
 * - Call web.takeScreenshot (optional: full page, label)
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in';

test('Take a screenshot of page', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.takeScreenshot(page, { screenshotText: 'Page screenshot', screenshotFullPage: true });
});
