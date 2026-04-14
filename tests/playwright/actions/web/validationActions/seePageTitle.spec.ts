/**
 * PlayQ Example: validation.seePageTitle
 *
 * Purpose: Confirm page title contains/equals expected text.
 * Steps:
 * - Navigate
 * - Check page title
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in';

test('See page title contains LetCode with Koushik', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.seePageTitle(page, 'LetCode with Koushik', { screenshot: false });
});
