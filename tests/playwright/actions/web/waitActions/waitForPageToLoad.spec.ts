/**
 * PlayQ Example: web.waitForPageToLoad
 *
 * Purpose: Wait for the page to finish loading.
 * PatternIQ: Not applicable.
 * Steps:
 * - Open page
 * - Wait for load state and key selectors
 */

import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/waits';

test('Wait for page to load after navigation', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.waitForPageToLoad(page);
  await web.waitForHeader(page, 'Wait', 'Wait');
});
