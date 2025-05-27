#!/usr/bin/env node

const { chromium } = require('playwright-extra');

const ticker = process.argv[2]
const url = `https://www.bloomberg.com/quote/${ticker}`;

if (!ticker) {
  console.error('Error: No ticker provided. Usage: node bin/fetch.js USDEUR:CUR');
  process.exit(1);
}

(async () => {
  const browser = await chromium.launch({ headless: false });
  const page = await browser.newPage();

  // Load the page (don't wait for network to fully idle)
  // Allow dynamic content
  await page.goto(url);
  await page.waitForTimeout(3000);

  // Print full page HTML content
  const content = await page.content();
  console.log(content);

  // Close browser
  await browser.close();
})();
