/**
 * PlayQ Example: web.logFail
 *
 * Purpose: Log a failing step to the PlayQ report.
 * PatternIQ: Not applicable.
 * Steps:
 * - Call web.logFail with a message
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

test('Reporting: logFail attaches failure message', async () => {
  await web.logFail('A recoverable failure was logged');
});
