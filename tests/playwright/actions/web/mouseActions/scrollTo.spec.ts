/**
 * PlayQ Example: web.scrollTo
 *
 * Purpose: Scroll the page until a target element is in view.
 * Page: See 'url' constant.
 * PatternIQ: Provide { pattern, fieldType } if resolving a named element.
 * Steps:
 * - Open page
 * - Resolve target element
 * - Scroll into view
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/';

test('Mouse: scrollTo specific Y', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.scrollTo(page, 0, 800);
});
