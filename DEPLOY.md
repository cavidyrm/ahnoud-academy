# Deploy — Ahnoud Academy

Deploy-ready files matching the live repo `cavidyrm/ahnoud-academy` (nginx static image → GHCR → docker compose behind Traefik).

## How to apply

Copy the contents of this folder over the repository root, keeping the same layout, then commit and push to `main` — the existing GitHub Actions workflow builds and deploys automatically. No workflow changes are needed.

```
Ahnoud Academy Landing.dc.html   replaced  (production build — see below)
404.dc.html                      replaced
support.js                       unchanged runtime
assets/logo-dark.svg             unchanged
assets/logo-lime.svg             unchanged
assets/favicon.svg               NEW
assets/apple-touch-icon.svg      NEW
robots.txt                       NEW
sitemap.xml                      NEW
site.webmanifest                 NEW
Dockerfile                       updated  (copies the new root files)
nginx.conf                       updated  (real 404s, cache policy, headers)
docker-compose.yml               updated  (www → apex 301)
.dockerignore                    updated
SEO.md                           NEW  (launch checklist — not shipped in the image)
```

`.github/workflows/deploy.yml` is unchanged.

## What changed in the HTML

- Design-review **Tweaks panel removed** — markup, state, `localStorage['ahnoud-tweaks']` restore/save, and the device-mode override. Layout now derives only from the real viewport. `padelFirst` is fixed to `true`.
- Device-frame preview wrappers removed.
- Asset paths are **root-absolute** (`/support.js`, `/assets/…`) — required because `404.html` can be served for a nested URL.
- 404 page's home link points at `/`.
- Favicon, apple-touch icon, manifest, `theme-color`.
- Full SEO head: title, description, canonical, Open Graph, Twitter card, JSON-LD (`SportsActivityLocation` + `WebSite`).
- 404 is `noindex,follow` and now returns a real HTTP 404.
- Every collection swipes on mobile/tablet; `prefers-reduced-motion` honoured; focus rings, skip link and ARIA wiring added.

## Before this goes live

These are placeholders in the shipped files — see `SEO.md` for the full list:

1. Real photography (all images are Unsplash URLs).
2. `assets/og-image.jpg` at 1200×630 for social previews.
3. Raster icons: `favicon.ico`, `assets/icon-192.png`, `icon-512.png`, `icon-maskable-512.png` (the manifest already references them).
4. Contact block: street address, phone, email, hours; real map embed.
5. Social profile URLs (currently `#top`) — also update `sameAs` in the JSON-LD.
6. JSON-LD placeholders: telephone, email, address, geo coordinates.
7. `hreflang` / `/fa/` locale — omitted on purpose until a Persian URL exists.

## Verify after deploy

```bash
curl -I https://ahnoudacademy.com/                  # 200, Cache-Control: max-age=0, must-revalidate
curl -I https://ahnoudacademy.com/does-not-exist    # 404  (was 200 before this change)
curl -I https://www.ahnoudacademy.com/              # 301 → https://ahnoudacademy.com/
curl -s https://ahnoudacademy.com/robots.txt
curl -s https://ahnoudacademy.com/sitemap.xml
```

Then run the Rich Results Test on the homepage and submit the sitemap in Search Console.
