
# Dean & Camper – AI Intake & Website

**File:** `SYSTEM-SPEC.md`  **Version:** 1.0 (2026-02-10)  **Owner:** Dean & Camper, P.A.  **Scope:** End‑to‑end specification for AI chat intake, qualification rules, Spanish handling, Zapier automations, Dropbox storage, and website homepage deployment.

---

## 1. Objectives
- Provide a consistent, attorney‑ready intake packet for every chat interaction.
- Auto‑route **Qualified**, **Disqualified**, and **No‑Response** leads to the correct Dropbox structure.
- Preserve Spanish originals and provide attorney‑reviewable English translations.
- Minimize staff time with Zapier automation while maintaining data integrity.
- Deliver a single, production‑ready homepage file and required assets.

---

## 2. Canonical Data Schema (Intake JSON)
This JSON is the single source of truth for a completed chat.

```json
{
  "language": "es",
  "name": "",
  "phone": "",
  "email": "",
  "accident_type_en": "",
  "accident_type_es": "",
  "accident_date": "",
  "state": "",
  "injury_confirmed": true,
  "represented": false,
  "summary_es": "",
  "summary_en": "",
  "qualified": true,
  "source": "Website Chat",
  "page_source": "",
  "translation_note": "English summary auto-translated from Spanish for attorney review.",
  "timestamp": ""
}
```

### Field Notes
- `language`: ISO 639‑1 code (e.g., `en`, `es`).
- `summary_es` = user’s original Spanish when `language = es`.
- `summary_en` = machine translation of the original summary.
- `represented = true` ⇒ **Auto‑disqualify**.
- `injury_confirmed = false` ⇒ **Auto‑disqualify**.
- `page_source`: the URL or page slug where chat started (e.g., `/car-accidents`).
- `timestamp`: ISO‑8601 with timezone (e.g., `2026-02-10T21:02:00-06:00`).

---

## 3. Qualification Logic
A lead is **QUALIFIED** only if **all** conditions are met:
1. `injury_confirmed = true`
2. `represented = false`
3. Accident type within practice scope (see §7)
4. Jurisdiction within **Florida** or **Alabama** (derived from `state`)
5. At least one valid contact method (`phone` or `email`)

Otherwise, set `qualified = false` (Disqualified) or mark as No‑Response if chat abandoned.

---

## 4. Dropbox Folder Structure
Root path: `/Leads`

```text
/Leads
├── /Qualified
│   └── LastName_FirstName_YYYY-###
│       ├── intake.json
│       ├── summary_en.txt
│       ├── summary_es.txt
│       └── transcript.txt
│
├── /Disqualified
│   └── LastName_FirstName_YYYY-###
│       └── transcript.txt
│
└── /No-Response
    └── LastName_FirstName_YYYY-###
        └── transcript.txt
```

**Naming Convention (strict):** `LastName_FirstName_YYYY-###`  
Example: `Garcia_Maria_2026-014`

---

## 5. Zapier Automations

### Zap 1 — Qualified Leads
**Trigger:** Chat completed AND `qualified = true`

**Actions:**
1. (Conditional) If `language = es`, translate `summary_es → summary_en` and attach `translation_note`.
2. Create folder: `/Leads/Qualified/{CaseID}`
3. Save files:
   - `intake.json` (exact schema in §2)
   - `summary_en.txt` (required; fallback to English if original is English)
   - `summary_es.txt` (include if `language = es`, else omit or create empty with note)
   - `transcript.txt` (full chat transcript)
4. Notify intake via Email + SMS with folder link + key fields (name, phone, state, accident type, timestamp).

**Error handling:** If Dropbox write fails, retry 3x with exponential backoff; on final failure, send alert email.

---

### Zap 2 — Disqualified Leads
**Trigger:** Chat completed AND `qualified = false`

**Actions:**
1. Create folder: `/Leads/Disqualified/{CaseID}`
2. Save `transcript.txt`
3. (Optional) Email daily digest of disqualified leads to intake.

---

### Zap 3 — No Response
**Trigger:** Chat abandoned or timed out (no reply for N minutes; recommend N = 10)

**Actions:**
1. Create folder: `/Leads/No-Response/{CaseID}`
2. Save partial `transcript.txt`
3. (Optional) Send one polite follow‑up SMS if contact provided.

---

## 6. Spanish Intake & Translation
- Chat detects language and mirrors user language by default.
- Preserve **original Spanish** summary in `summary_es`.
- Generate **attorney‑reviewable English** in `summary_en` with a disclaimer: `translation_note`.
- Never overwrite originals. Never merge languages in a single summary field.

---

## 7. Practice Scope (Authoritative List)
- Car Accident Injuries
- Truck Accident Injuries
- Motorcycle Accident Injuries
- Wrongful Death
- Premises Liability
- Auto Insurance Claims
- Dog Bite Injuries
- Defective Product Injuries
- Boat & Jet Ski Injuries

Use this list for scope checks in qualification logic.

---

## 8. Website Homepage Deployment
**Primary file:** `COMPLETE-HOMEPAGE-index.html`  
**Rename on deploy:** `index.html`

**Required assets to upload alongside:**
```
/Badges            (folder with 4 badge images)
/dean-camper-logo-main.png
/dean-camper-logo.webp
/dean-camper-logo-og.png
```

**Verification checklist:**
- Hero: “Best Personal Injury Lawyers” (blue section)
- Trust bar icons (💰 ⚖️ 🏆 🌎)
- 9 practice area cards
- Why Choose Us (light gray)
- Scrolling credential badges
- Scrolling verdicts & settlements (green amounts)
- Attorney profiles (Shane Dean, Chad Camper)
- CTA block with 4 phone numbers
- Footer (black)

**Notes:** Links to individual practice pages may be inactive locally; they’ll work on server once linked.

---

## 9. Notifications (Email + SMS)
**Recipients:** Intake distribution list (configurable).  
**Subject (Email):** `[Qualified Lead] {LastName_FirstName_YYYY-###} — {Accident Type} — {State}`

**Body includes:**
- Name, phone, email
- Accident type, date, state
- Qualified: true/false
- Folder link
- Timestamp

**SMS:** Condensed version with CaseID, name, phone, accident type, folder link.

---

## 10. Data Validation
- **Phone:** E.164 formatting where possible; otherwise, store raw user input + normalized copy.
- **Email:** Basic RFC 5322 regex; reject obvious invalids (no `@`, no domain).
- **Dates:** Prefer `YYYY‑MM‑DD`; store raw + normalized.
- **State:** Two‑letter USPS code; validate against `FL`, `AL` for in‑scope.

On validation failure: prompt the user once to correct; if still invalid, proceed but flag in `intake.json` as `validation_warnings` (array of strings).

---

## 11. Security & Privacy
- Do not store payment data; no retainers collected via chat.
- Avoid collecting SSNs or DOB unless strictly necessary.
- Store only intake essentials in Dropbox; access limited to firm staff.
- Include standard website disclaimer: information is not legal advice; no attorney‑client relationship until agreement.

---

## 12. Operational Metrics (Optional)
- Time‑to‑folder (chat end → Dropbox write)
- Qualified rate (%)
- Language distribution (en/es)
- Response latency (AI + user)
- Follow‑up conversion for No‑Response

---

## 13. Change Log
- **1.0 (2026‑02‑10):** Initial consolidated production spec created from final intake + website bundle.

---

## 14. Appendix — Example CaseID
Pattern: `LastName_FirstName_YYYY-###`  
Example: `Smith_Ana_2026-021`

**Files:**
- `/Leads/Qualified/Smith_Ana_2026-021/intake.json`
- `/Leads/Qualified/Smith_Ana_2026-021/summary_en.txt`
- `/Leads/Qualified/Smith_Ana_2026-021/summary_es.txt`
- `/Leads/Qualified/Smith_Ana_2026-021/transcript.txt`

---

**End of SYSTEM-SPEC.md**
