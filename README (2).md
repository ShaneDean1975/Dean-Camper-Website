
# Dean & Camper – AI Intake & Website Package (Desktop + Mobile)

**Build Date:** 2026-02-13 18:04:28 

This archive bundles the final production specification and two GA4‑instrumented prototypes (mobile & desktop).

## Contents

1. **SYSTEM-SPEC.md**  
   Canonical system specification covering:
   - Intake JSON schema & validation
   - Qualification logic (Qualified / Disqualified / No‑Response)
   - Spanish intake + English translation policy
   - Zapier automations
   - Dropbox folder structure & naming standard
   - Homepage deployment checklist

2. **mobile-prototype-GA4.html**  
   Mobile, long‑scroll clickable prototype with:
   - Sticky call CTA, practice grid, results, CTA band
   - AI Intake Chat (simulated)
   - GA4 virtual pageviews + event tracking

3. **desktop-prototype-GA4.html**  
   Desktop prototype mirroring the approved structure:
   - Top nav router (Home, Practice, Results, Attorneys, Contact)
   - Hero CTAs, practice grid, results, attorney cards, CTA band
   - Contact (call options) view
   - Chat modal with sample conversation
   - GA4 virtual pageviews + event tracking

4. **README.md** (this file)

---

## GA4 Setup
Both prototypes include a GA4 base tag. **Replace** `G-XXXXXXXXXX` in the `<head>` with your Measurement ID.

**Tracked events include:**
- `page_view` (virtual screens)
- `nav_click`
- `call_cta_click`, `call_click`, `call_click_from_practice`
- `chat_cta_click`, `chat_modal_open`, `chat_start`, `chat_modal_close`, `chat_start_from_practice`
- `practice_card_click`

Use **GA4 DebugView** to validate events as you click through flows.

---

## How to Use
1. Open `mobile-prototype-GA4.html` and/or `desktop-prototype-GA4.html` in a browser.
2. Update GA4 Measurement ID to your property.
3. Verify events via DebugView.
4. Use `SYSTEM-SPEC.md` as the source of truth for production wiring (AI intake widget + Zapier + Dropbox).

---

## Change Log
- **v2** – Added `desktop-prototype-GA4.html` and updated README.
- **v1** – Initial package with SYSTEM-SPEC and mobile prototype.
