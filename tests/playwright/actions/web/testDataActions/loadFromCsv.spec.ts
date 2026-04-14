/**
 * Example: testData.loadFromCsv
 *
 * Purpose: Loads CSV data from a file path and verifies rows.
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

const csvPath = 'PlayQ_PROJECT/test-data/lambdaTest.csv';

test('Load CSV test data', async ({ page }) => {
  const rows = await web.loadFromCsv(csvPath);
  expect(Array.isArray(rows)).toBeTruthy();
  expect(rows.length).toBeGreaterThan(0);
  console.log('Loaded CSV Rows:', rows);
});
