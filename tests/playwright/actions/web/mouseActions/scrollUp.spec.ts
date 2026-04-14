/**
 * PlayQ Example: web.scrollUp
 *
 * Purpose: Scroll upward on the page to improve visibility of elements.
 * Page: See 'url' constant.
 * PatternIQ: Not required.
 * Steps:
 * - Open page
 * - Call scrollUp
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/';

test('Mouse: scrollUp by 300px', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.scrollDown(page, 600);
  await web.scrollUp(page, 300);
});
