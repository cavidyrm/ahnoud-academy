# Handoff: Ahnoud Academy — Landing Page + 404

## Overview
Marketing landing page for **Ahnoud Academy**, a tennis & padel academy, plus a matching 404 error page. Fully bilingual (English LTR / Persian RTL) with a persisted language toggle. The goal of the page: present the academy's programs, coaches, facilities, shop, and schedule, and drive visitors to **book a trial session**.

## About the Design Files
The files in this bundle are **design references created in HTML** — interactive prototypes showing the intended look and behavior. They are **not production code to ship directly**. The task is to **recreate these designs in your target codebase's environment** (Next.js, Astro, plain HTML/CSS, etc.) using its established patterns, i18n tooling, and component libraries. If no environment exists yet, choose an appropriate framework (a static-friendly one like Astro or Next.js is a good fit for a marketing site) and implement the designs there.

## Fidelity
**High-fidelity.** Colors, typography, spacing, copy, and interactions are final and should be recreated pixel-perfectly. The only placeholders are:
- **All photography** — Unsplash URLs are stand-ins. Replace with real academy photography (hero action shot, courts wide shot, program shots, coach portraits, facility thumbs, product shots).
- **Contact details** — address and phone number contain `[street address]` / `···` placeholders.
- **Map** — the contact section map is a placeholder block; embed a real map.
- **Social links** — Instagram / WhatsApp / Telegram links currently point to `#top`.

## ⚠ Not for production
- The floating **"Tweaks" panel** (top-right: device preview, language, padel-first toggle) is a **design-review tool only**. Do not implement it. The language toggle in the bottom nav IS part of the design.
- The `[ … ]` striped placeholder blocks behind images are dev affordances; in production, images are required and no placeholder state is needed.

## Screens / Views

### 1. Landing page (`Ahnoud Academy Landing.dc.html`)
One long-scroll page. Sections in order, each numbered `( 01 )`–`( 10 )` in the corner badge system:

1. **Hero** — cream `#f5f4ef` bg. Top row: logo + "AHNOUD" wordmark (left), badge "Tennis · Padel Academy" (right). Two-col grid (1.15fr/1fr, 64px gap): huge uppercase H1 ("An academy built for serious play") bottom-aligned with a max-width 400px sub-paragraph. Below, a rule-topped row: discipline list (Tennis / Padel / Junior Development) and a stat + outlined CTA button "Book a Trial Session +". Full-bleed hero image, 72vh (min 520px), slight parallax (translateY up to 44px at 0.08× scroll, on a 1.1 scale).
2. **Marquee** — near-black `#101210` strip, italic 900 uppercase 22px "Ahnoud Academy · Tennis · Padel" repeating, 26s linear infinite leftward scroll, pauses on hover. Lime dots `#d9f64a` between words. Always LTR.
3. **About** (dark `#101210`) — large rounded image (74vh, radius 12) with four giant outlined words overlapping its edges: "Ahnoud" (top center), "Tennis" (left), "Padel" (right), "Academy" (bottom center), color `rgba(245,244,239,.9–.94)`. Below: badge row, then two-col: H2 "Precision in every detail" + paragraph and three lime-square bullets.
4. **Programs** — light. Header: H2 "Two Games. / One Standard." with lime square bullet on line 2; right-aligned tab switcher "01 Padel / 02 Tennis" (active: `#12140f` text + 3px lime bottom border; inactive: `rgba(18,20,15,.32)`). Below: 3 full-width image rows (320px tall, radius 12, 10px gaps, 10px page inset). Row default state: centered program name over a horizontal rule, level tag chip bottom-start, "+" at end-center. Hover: title fades up/out, a 108px `#101210` panel slides up from bottom containing level·duration (lime), outlined name chip, and description (right-aligned).
5. **Coaches** — light. Header two-col (H2 + sub). 4-col card grid (desktop) / horizontal scroll-snap rail (tablet 36% cards, mobile 76% cards). Card: 3/3.6 portrait (radius 12, img scales 1.06 on hover), rule-topped meta: number `01`, role in olive `#5f7014`, name 21px uppercase 700, credential 13.5px `#565850`. Cards lift −6px on hover.
6. **Facilities** (dark) — H2 "Built to tournament standard", then 5 rule-separated rows: number / name (uppercase 700, fluid 20–34px) / description / 150×96 image thumb. Row hover: bg `#15171372` + 14px inline-start padding shift.
7. **Shop** — light, same card grid/rail pattern as Coaches. Card: 3/3.4 product image, number, tag (olive), name, price row with outlined "Enquire" button (hover: lime fill).
8. **Schedule** — light. H2 + outlined CTA "Request full schedule +". 4 rule-separated rows: name (22px uppercase) / days / time (tabular-nums) / tag (olive, end-aligned). Row hover: bg `#eeede6` + padding shift.
9. **Testimonials** — light, 3-col grid of rule-topped quotes with lime-square + name/role signature. −4px lift on hover.
10. **FAQ** — two-col (1fr/1.4fr): H2 left, accordion right. 5 items, one open at a time (first open by default), "+" rotates 45° when open, body max-height animates .35s.
11. **Contact** — two-col (1fr/1.1fr): H2 + 4 rule-topped label/value rows (Address, Phone, Email, Hours) + dark CTA button; right: 560px map placeholder (radius 12).
12. **Footer** — dark, **sticky reveal**: footer is `position:sticky; bottom:0; z-index:0` and the entire page content above sits in a wrapper with `z-index:1` and a large drop shadow, so the footer is revealed from behind as you finish scrolling. Contains: logo row, 4-col grid (brand col with H2 "Ready to play?", lime CTA button, tagline; Explore nav links; Programs list; Follow links), a giant centered "Ahnoud" wordmark (fluid up to 220px), and a copyright bar.

**Floating nav (all viewports)** — fixed, bottom 24px, centered. Dark `#2c2d29` pill (radius 18, 7px padding): logo tile (44×44, `#3b3c37`, radius 12), link pills (active section highlighted via scroll-spy: 1px `rgba(245,244,239,.45)` border + `rgba(245,244,239,.06)` bg), cream "Book a Trial" CTA pill (hover: lime), 44×44 language toggle tile ("فا"/"EN"). On mobile the link rail scrolls horizontally. **Nav width trick:** each label reserves the width of its English text (hidden sizer span) and the Persian label is overlaid at a computed font size so the nav never reflows between languages.

### 2. 404 page (`404.dc.html`)
Cream bg, same header (logo + language toggle). Centered: badge "( 404 — Page not found )", giant "4 ● 4" figure (the zero is a lime ball with a 3px inset dark ring, up to 300px), uppercase H1 "That one landed out of bounds", sub-copy, dark CTA "Back to home +". Rule-topped footer bar with copyright. Fully bilingual, reads the same persisted language key.

## Interactions & Behavior
- **Language toggle** (nav tile + 404 header): switches EN ↔ FA, flips `dir` to `rtl`, swaps font stacks, persists to `localStorage['ahnoud-lang']`. All letter-spacing goes to 0 in Persian; line-heights loosen (0.94 → 1.12 for display type).
- **Scroll spy**: section whose top is above 45% of viewport height becomes active in nav.
- **Scroll reveal**: sections below the fold start `opacity:0; translateY(28px)` and reveal via IntersectionObserver (threshold 0.12, `.7s ease`). Grids/lists stagger children 90ms apart (`.6s cubic-bezier(.25,.1,.25,1)`).
- **Hero parallax**: image `translateY(min(44px, scrollY × 0.08))`.
- **Programs tab**: Padel/Tennis switch swaps the 3 program rows (content + images).
- **Program row hover**: described above (`.32s` title fade, `.4s cubic-bezier(.4,0,.2,1)` panel slide).
- **FAQ accordion**: single-open, max-height transition `.35s ease`.
- **Buttons**: primary hover swaps to lime `#d9f64a` and gap widens 12→18px; active state `scale(.97)` on nav CTA.
- **Image hovers**: card images scale 1.06–1.08 over `.6s cubic-bezier(.25,.1,.25,1)`.
- **Smooth scrolling**: `html { scroll-behavior: smooth }`, all nav links are same-page anchors.
- **Broken images**: prototype hides `<img>` on error, revealing striped placeholder — not needed in production.

## Responsive Behavior
Breakpoints by content width: **mobile < 720px**, **tablet 720–1079px**, **desktop ≥ 1080px**.
- Mobile: all 2-col grids stack to 1 col; card grids become scroll-snap rails (76% wide cards); facilities thumbs hidden; program descriptions hidden; program rows 260px; footer 2-col with full-width brand column; page padding 20px.
- Tablet: rails with 36% cards; otherwise desktop layout.
- Fluid type: display sizes are `clamp`-like (min px, vw-based, max px) — exact triples are in the prototype source (`fpx(min, %, max)` helper), e.g. H1 = 40px / 5.6vw / 92px, H2 = 34 / 4.8 / 76, footer wordmark = 48 / 13 / 220.

## State Management
- `lang: 'en' | 'fa'` — persisted (`localStorage['ahnoud-lang']`).
- `tab: 'padel' | 'tennis'` — programs section, default `padel`.
- `faqOpen: number` — index of open FAQ, `-1` = none, default `0`.
- `active: string` — scroll-spy section id.
- `progHover: number` — hovered program row.
- No data fetching; all copy is static in both languages (full EN + FA copy decks are in the prototype's `copy()` method — reuse verbatim).

## Design Tokens
**Colors**
- Cream (page bg): `#f5f4ef` · hover row tint: `#eeede6`
- Ink (text): `#12140f`
- Dark bg: `#101210` · nav pill: `#2c2d29` · nav tile: `#3b3c37` · panel: `#1c1d19`
- Lime accent: `#d9f64a` · olive (lime-on-light text): `#5f7014`
- Muted on light: `#565850` (body), `#8a8c80` (labels)
- Muted on dark: `#c9ccbf` (body), `#a9ac9f`, `#9d9e96`, `#8d9184` (labels)
- Hairlines: `rgba(18,20,15,.2)` on light, `rgba(245,244,239,.14)` on dark

**Typography**
- EN: **General Sans** (Fontshare), weights 400–700 (+900 italic for marquee).
- FA: **Kalameh** (webfont, `size-adjust: 150%`), fallback **Vazirmatn** (Google Fonts).
- Labels/badges: 11–12px, 600, uppercase, tracking `.12em` (EN) / 0 (FA).
- Display: 700, uppercase, tracking `-0.015em` (EN) / 0 (FA), line-height .94–.98 (EN) / 1.12–1.14 (FA).
- Body: 14.5–17px, line-height 1.6–1.7.

**Spacing & shape**
- Section padding: 120–150px vertical; page gutter `clamp(24px, 4vw, 64px)` (20px mobile).
- Radii: 12px (images/cards), 9px (buttons), 18px (nav bar), 999px (pills), 6–7px (chips).
- Shadows: nav `0 18px 48px rgba(16,18,16,.38)`; content-over-footer `0 30px 80px rgba(16,18,16,.35)`.
- Lime square bullet motif: 12×12px, used in bullets, headings, and signatures.

## Assets
- `assets/logo-dark.svg` — Ahnoud mark, dark ink (light backgrounds).
- `assets/logo-lime.svg` — Ahnoud mark, lime (dark backgrounds).
- `uploads/Asset 8.svg` (project root) — original source logo file.
- All photos: Unsplash placeholders → replace with real photography.
- Fonts: General Sans via Fontshare CSS; Kalameh via CDN `@font-face`; Vazirmatn via Google Fonts. For production, self-host all three.

## Files
- `Ahnoud Academy Landing.dc.html` — full landing page (template + logic + both language copy decks).
- `404.dc.html` — error page.
- `support.js` — prototype runtime; lets the HTML files open directly in a browser. Not part of the design.
- `assets/` — logo SVGs.

Open `Ahnoud Academy Landing.dc.html` in a browser to view the working prototype.
