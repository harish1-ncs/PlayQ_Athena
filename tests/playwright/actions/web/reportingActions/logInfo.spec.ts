/**
 * PlayQ Example: web.logInfo
 *
 * Purpose: Add an informational line to the PlayQ report.
 * PatternIQ: Not applicable.
 * Steps:
 * - Call web.logInfo with a message
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

test('Reporting: logInfo attaches message', async () => {
  await web.logInfo('This is an info log from reportingActions');
});
