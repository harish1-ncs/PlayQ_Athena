/**
 * PlayQ Example: web.scrollDown
 *
 * Purpose: Scroll downward on the page to reveal content.
 * Page: See 'url' constant.
 * PatternIQ: Not required.
 * Steps:
 * - Open page
 * - Call scrollDown
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/';

test('Mouse: scrollDown by 400px', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.scrollDown(page, 400);
});
