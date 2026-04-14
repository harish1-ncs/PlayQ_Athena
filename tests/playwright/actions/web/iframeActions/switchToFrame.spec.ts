/**
 * PlayQ Example: web.switchToFrame
 *
 * Purpose: Switch to an iframe using PatternIQ and interact within the frame.
 * Page: The Internet → /iframe
 * PatternIQ: pattern 'theinternet', fieldType 'iframe' (id 'mce_0_ifr')
 * Steps:
 * - Open page with web.openBrowser
 * - Resolve iframe via web.switchToFrame using PatternIQ
 * - Evaluate in frame context and verify content
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://the-internet.herokuapp.com/iframe';

test('IFrame: switchToFrame and read content', async ({ page }) => {
  await web.openBrowser(page, url);

  const frame = await web.switchToFrame(page, 'mce_0_ifr', { pattern: 'theinternet', fieldType: 'frames' });
  const setResult = await frame.evaluate(() => {
    const body = document.body as HTMLBodyElement;
    const prev = body.innerText || '';
    body.innerText = 'Hello from frame';
    return prev.length >= 0;
  });
  expect(setResult).toBeTruthy();

  const text = await frame.evaluate(() => document.body.innerText);
  expect(text).toContain('Hello from frame');
});
