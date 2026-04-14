/**
 * Example: testData.loadFromJson
 *
 * Purpose: Loads JSON data from a file path.
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const jsonPath = 'PlayQ_PROJECT/test-data/sample.json';

test('Load JSON test data', async ({ page }) => {
  // Create a small JSON file if not exists via page fixture inaccessible; assume present
  const data = await web.loadFromJson(jsonPath);
  expect(typeof data).toBe('object');
  console.log('Loaded JSON Data:', data);
});
