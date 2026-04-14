/**
 * PlayQ Example: testData.generateSampleData
 *
 * Purpose: Generate sample data based on a flexible schema.
 * PatternIQ: Not applicable.
 * Steps:
 * - Provide a schema object (supports nested/arrays)
 * - Call web.generateSampleData
 * - Validate types of returned values
 */
import { test, expect } from '@playwright/test';
import { web } from '@playq/core';

test('Generate sample data from schema', async () => {
  const schema = { firstName: 'string', lastName: 'string', age: 'number' };
  const data = await web.generateSampleData(schema);
  expect(typeof data.firstName).toBe('string');
  expect(typeof data.lastName).toBe('string');
  expect(typeof data.age).toBe('number');
  console.log('Generated Sample Data:', data);
});
