/**
 * PlayQ Example: web.waitForHeader
 *
 * Purpose: Wait for a page header to match expected text.
 * Page: See 'url' constant.
 * PatternIQ: Provide { pattern, fieldType: 'header' } to resolve heading.
 * Steps:
 * - Open page
 * - Wait for header text
 */

import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/waits';

test('Wait for H1 header text', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.waitForHeader(page, 'Wait', 'Wait', { partialMatch: false, screenshot: false });
});
