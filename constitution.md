# Website Crawler - Constitution

Non-negotiable principles for web crawling operations. These rules supersede all other practices.

## P1: Respect robots.txt

- Always check and obey `robots.txt` directives before crawling
- Never bypass `Disallow` rules, even if technically possible
- Respect `Crawl-delay` directives when specified
- If `robots.txt` is unreachable, treat the site as fully disallowed

## P2: Rate Limit Requests

- Never exceed 1 request per second to a single domain by default
- Adjust rate limits downward if the server shows signs of strain (429, 503 responses)
- Use exponential backoff on repeated failures
- Concurrent connections to a single domain MUST NOT exceed 2

## P3: Never Store Credentials

- Never capture, log, or store authentication tokens, cookies, or credentials found during crawling
- Redact sensitive data (API keys, passwords, session tokens) from crawl output
- If a page requires authentication, skip it and log the URL as "auth-required"

## P4: Report Total Pages

- Every crawl run MUST report a summary including:
  - Total pages discovered
  - Total pages successfully crawled
  - Total pages skipped (with reasons: robots.txt, auth, error)
  - Crawl duration
- Incomplete crawls MUST be clearly marked with the reason for interruption

## Validation Checklist

Before saving crawl results:

- [ ] P1: robots.txt checked and respected for all domains
- [ ] P2: Request rate stayed within limits (no 429/503 caused by crawling)
- [ ] P3: No credentials or sensitive tokens in output files
- [ ] P4: Crawl summary with total pages included in output
