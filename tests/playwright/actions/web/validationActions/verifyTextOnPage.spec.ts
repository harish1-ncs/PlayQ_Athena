/**
 * PlayQ Example: validation.verifyTextOnPage
 *
 * Purpose: Validate that specific text appears on the page.
 * PatternIQ: Provide pattern/location when resolving named areas.
 * Steps:
 * - Navigate
 * - Validate presence of expected text
 */

import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/dynamic_content';

test('Verify text on page: demonstrates ', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.verifyTextOnPage(page, 'demonstrates', { pattern: 'theinternet', partialMatch: false, screenshot: false });
});
