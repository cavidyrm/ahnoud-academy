# SEO & Launch Workflow — Ahnoud Academy

Everything below is scoped to this two-page site (landing + 404). Replace `ahnoudacademy.com` with the real domain before shipping.

---

## 0. How this site is deployed (from the repo)

nginx (`nginx:1.27-alpine`) serves the files statically: the Dockerfile copies `Ahnoud Academy Landing.dc.html` → `index.html` and `404.dc.html` → `404.html`, the image is built and pushed to `ghcr.io/cavidyrm/ahnoud-academy:latest` by `.github/workflows/deploy.yml` on every push to `main`, then pulled on the server via `docker compose`. Traefik terminates TLS for `ahnoudacademy.com`.

Because everything is served from the web root, in-page asset references are **root-absolute** (`/support.js`, `/assets/…`, `/site.webmanifest`) — relative paths would break on the 404 page when it is returned for a nested URL.

**Two nginx changes were required and are included:**
1. `try_files $uri $uri/ /index.html` → `try_files $uri $uri/ =404`. The old rule returned the landing page with HTTP **200** for every unknown URL, so the 404 page never rendered and crawlers indexed junk URLs as valid pages.
2. HTML now sends `Cache-Control: max-age=0, must-revalidate` (it was cached 7 days, so deploys were invisible to returning visitors); static assets get 30 days, JS/CSS 7 days, and `.webmanifest` is served as `application/manifest+json`. Security headers (`nosniff`, `SAMEORIGIN`, `Referrer-Policy`) added.

A www → apex 301 (Traefik `redirectregex`) was added to `docker-compose.yml` so only the canonical host is indexed.

## 1. Files in this bundle

| File | Purpose |
|---|---|
| `assets/favicon.svg` | Primary favicon — lime mark on a `#101210` rounded tile, 512 viewBox, scales to any size |
| `assets/apple-touch-icon.svg` | Full-bleed square variant for iOS home screen / maskable use |
| `site.webmanifest` | PWA/manifest: name, theme `#101210`, background `#f5f4ef`, icon set |
| `robots.txt` | Allows all crawlers, points to the sitemap |
| `sitemap.xml` | Both locales with `hreflang` alternates |

**Still to generate (raster, needed for older clients):** export from `favicon.svg` at
`favicon.ico` (32+16px, site root), `assets/icon-192.png`, `assets/icon-512.png`, `assets/icon-maskable-512.png` (with ~10% safe padding). The manifest already references those paths.

---

## 2. Head block (already in the handoff files)

```html
<link rel="icon" href="/favicon.ico" sizes="32x32">
<link rel="icon" href="/assets/favicon.svg" type="image/svg+xml">
<link rel="apple-touch-icon" href="/assets/apple-touch-icon.png">
<link rel="manifest" href="/site.webmanifest">
<meta name="theme-color" content="#101210">
```

Plus title, description, canonical, `hreflang` (en / fa / x-default), Open Graph and Twitter card tags. Note: in production these paths should be **root-absolute** (`/assets/…`); the prototype uses relative paths so the file opens from disk.

---

## 3. SEO workflow (do these in order)

**A. Per-page metadata**
1. `<title>` — 50–60 chars, brand last: *Ahnoud Academy — Tennis & Padel Coaching Built for Serious Play*.
2. `<meta name="description">` — 140–160 chars, includes "tennis", "padel", "coaching", city name, and a call to action.
3. One `<h1>` per page (the hero headline). Section headings stay `<h2>` — the current design already nests correctly.
4. `<link rel="canonical">` on every page, self-referencing, absolute.

**B. Bilingual / i18n**
5. Serve each language on its **own URL** (`/` for EN, `/fa/` for FA) rather than a client-side toggle only — a `localStorage` switch alone is invisible to crawlers. Keep the toggle as a link between the two URLs. **Until `/fa/` exists, the `hreflang` tags and the `/fa/` sitemap entry are intentionally omitted** (they would point at a 404); the strings are in `SEO.md` §2 ready to re-add. On this nginx setup, build a second HTML with `lang="fa" dir="rtl"` and add `location /fa/ { try_files /fa/index.html =404; }`.
6. `<html lang="en" dir="ltr">` / `<html lang="fa" dir="rtl">` set server-side per locale.
7. Reciprocal `hreflang` on both pages plus `x-default` → EN.

**C. Structured data** (JSON-LD in `<head>`)
8. `SportsActivityLocation` (or `LocalBusiness`) with `name`, `image`, `address` (PostalAddress), `telephone`, `email`, `openingHoursSpecification`, `geo`, `sameAs` (Instagram/WhatsApp/Telegram), `priceRange`.
9. `FAQPage` built from the 5 FAQ entries — eligible for rich results, copy already exists in both languages.
10. `BreadcrumbList` if more pages get added later.

**D. Content & links**
11. Real `alt` text on every image (hero, program, coach, facility, product) — descriptive, not keyword-stuffed. Decorative images get `alt=""`.
12. Replace the placeholder contact block: real street address, phone in `tel:` link, email in `mailto:`, hours.
13. Point the social links at real profiles (currently `#top`) and add them to `sameAs` in the JSON-LD.
14. Embed a real map (Google Maps iframe with `loading="lazy"`, or a static image linking out) in place of the map placeholder.

**E. Crawl & index**
15. Ship `robots.txt` + `sitemap.xml` at the domain root; update `lastmod` on each deploy.
16. 404 page returns a **real HTTP 404 status** (not 200) and carries `<meta name="robots" content="noindex,follow">` — already set.
17. Verify the property in Google Search Console + Bing Webmaster Tools, submit the sitemap.
18. Force HTTPS, pick one canonical host (`www` or bare) and 301 the other.

**F. Social preview**
19. Create `assets/og-image.jpg` at **1200×630** — hero action shot with the lime mark; test with the Facebook Sharing Debugger and Twitter Card Validator.

**G. Performance (ranking factor)**
20. Self-host General Sans, Kalameh and Vazirmatn as `woff2` with `font-display: swap` and `<link rel="preload">` on the two weights used above the fold — removes three third-party origins.
21. Replace Unsplash URLs with locally served, compressed AVIF/WebP; set explicit `width`/`height` to prevent CLS; `loading="lazy"` + `decoding="async"` on everything below the fold; `fetchpriority="high"` on the hero image only.
22. Target Core Web Vitals: LCP < 2.5s, INP < 200ms, CLS < 0.1. Watch CLS in the footer reveal and hero parallax — both are transform/opacity only, so they should not shift layout.
23. Respect `prefers-reduced-motion`: disable the hero parallax, footer reveal, marquee and stagger animations.

**H. Accessibility (indirect SEO)**
24. Contrast check the muted greys (`#8a8c80` on cream is borderline at small sizes).
25. Keyboard focus states on nav pills, tabs, FAQ buttons and the CTA — the glass nav currently relies on hover only.
26. `aria-expanded` on FAQ buttons, `aria-current` on the active nav link, `aria-pressed` on the Padel/Tennis tabs, and an accessible name on the language toggle.
27. A visible "skip to content" link before the fixed nav.

---

## 4. Pre-launch checklist

- [ ] Real domain + HTTPS + canonical host redirect
- [ ] Raster favicons + `og-image.jpg` generated
- [ ] Real photography swapped in, all `alt` text written
- [ ] Contact details, map, social links real
- [ ] `/fa/` locale served server-side with correct `lang`/`dir`
- [ ] JSON-LD validated (Rich Results Test)
- [ ] `sitemap.xml` + `robots.txt` live, submitted to Search Console
- [ ] 404 returns status 404
- [ ] Lighthouse ≥ 90 on Performance, Accessibility, Best Practices, SEO
- [ ] Analytics + a conversion event on "Book a Trial"
