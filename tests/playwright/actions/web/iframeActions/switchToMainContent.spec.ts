/**
 * PlayQ Example: web.switchToMainContent
 *
 * Purpose: Switch back to the main document after working inside an iframe.
 * Page: The Internet → /iframe
 * PatternIQ: pattern 'theinternet', fieldType 'iframe' (id 'mce_0_ifr')
 * Steps:
 * - Open page and switch into iframe via PatternIQ
 * - Evaluate in frame and verify content is present
 * - Call web.switchToMainContent to return to main frame
 * - Verify main page heading
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/iframe';

test('IFrame: switch back to main content', async ({ page }) => {
  await web.openBrowser(page, url);
  const frame = await web.switchToFrame(page, 'mce_0_ifr', { pattern: 'theinternet', fieldType: 'frames' });
  const frameText = await frame.evaluate(() => document.body.innerText || '');
  expect(frameText.length).toBeGreaterThan(0);
  
  await web.switchToMainContent(page);

  const heading = await web.executeScript(page, () => document.querySelector('h3')?.textContent || '');
  expect(heading).toContain('An iFrame containing');
});
