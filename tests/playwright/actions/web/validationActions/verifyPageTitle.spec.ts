/**
 * PlayQ Example: validation.verifyPageTitle
 *
 * Purpose: Validate the current page title string.
 * Steps:
 * - Navigate
 * - Verify page title matches expectation
 */

import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/';

test('Verify exact page title', async ({ page }) => {
  await web.openBrowser(page, url);

  // Exact page title for the-internet.herokuapp.com
  await web.verifyPageTitle(page, 'The Internet', {
    pattern: 'theinternet',
    screenshot: false
  });
});
