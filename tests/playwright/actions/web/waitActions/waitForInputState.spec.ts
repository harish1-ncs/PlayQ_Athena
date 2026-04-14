/**
 * PlayQ Example: web.waitForInputState
 *
 * Purpose: Wait for an input or button to reach a desired state (enabled/disabled).
 * Page: See 'url' constant.
 * PatternIQ: Provide { pattern, fieldType } to resolve element by name.
 * Steps:
 * - Open page
 * - Wait for element state
 */

import { test } from '@playwright/test';
import { web } from '@playq/core';

const url = 'https://letcode.in/edit';

test('Wait for Full Name input enabled', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.waitForInputState(page, 'Enter your full Name', 'enabled', { pattern: 'letcodesamples' });
});

test('Wait for No Edit input disabled', async ({ page }) => {
  await web.openBrowser(page, url);
  await web.waitForInputState(page, 'Confirm edit field is disabled', 'disabled', { pattern: 'letcodesamples' });
});
