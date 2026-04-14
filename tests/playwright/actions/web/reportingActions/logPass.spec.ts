/**
 * PlayQ Example: web.logPass
 *
 * Purpose: Log a passing step to the PlayQ report.
 * PatternIQ: Not applicable.
 * Steps:
 * - Call web.logPass with a message
 */
import { test } from '@playwright/test';
import { web } from '@playq/core';

test('Reporting: logPass attaches success message', async () => {
  await web.logPass('Step passed successfully');
});
