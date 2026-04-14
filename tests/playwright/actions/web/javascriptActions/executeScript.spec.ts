/**
 * PlayQ Example: web.executeScript
 *
 * Purpose: Demonstrates executing JavaScript in the page context
 *          and asserting on the returned value.
 * Page: The Internet (homepage)
 * PatternIQ: Not required for this example.
 * Steps:
 * - Open the page via web.openBrowser
 * - Call web.executeScript with a function accessing document.title
 * - Assert the returned string contains expected text
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/';

test('JavaScript: executeScript returns document.title', async ({ page }) => {
  await web.openBrowser(page, url);

  const title = await web.executeScript(page, () => document.title);
  expect(title).toContain('The Internet');
});
