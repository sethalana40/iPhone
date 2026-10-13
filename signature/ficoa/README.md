# Seth Plunkett — FICOA Communications Email Signature

Rebuilt the robust way (matching the MasTec signature's approach):
logo embedded directly in the file as base64 — not loaded from an
external URL — and pre-sized to its true on-screen pixel dimensions
(132×36) so Apple Mail's own image auto-scaling can't distort it.

- `signature.html` — the finished, ready-to-use signature.
- `template.html` — same markup with `{{LOGO_SRC}}` unfilled.
- `assets/ficoa-logo.png` — logo resized to 132×36, the copy actually embedded in `signature.html`.
- `assets/ficoa-logo-original.jpg` — the original uploaded logo, full resolution, kept for reference.

Colors/layout match the real FICOA signature (pulled from the
`ficoa-signature` Vercel deployment): dark gray name/title/company
(#595959 / #404040), FICOA red (#c0392b) for the website and email
links, black underlined phone number, thin gray divider between logo
and text.

## Install on iPhone (Mail app)

Same method as the MasTec signature — see `../signature/README.md`
for the full walkthrough. Short version:

1. Get `signature.html` onto your iPhone (AirDrop, iCloud Drive, or
   the raw GitHub link) and open it in **Safari**.
2. Tap and hold → **Select All** → **Copy**.
3. **Settings → Mail → Signature** → per-account → paste into the
   `seth.plunkett@ficoa.com` signature box.
4. Confirm the logo, divider, and text sit side by side in a test email.

This is expected to work cleanly — iOS Mail preserves the table
layout correctly (confirmed with the MasTec signature earlier).

## Install on Mac (Apple Mail)

Apple Mail's Signature editor on macOS cannot represent a side-by-side
table layout at all — this was confirmed at length with the MasTec
signature (GUI paste always flattens it to a stacked column; directly
editing Mail's signature file gets silently overwritten by Mail itself
within seconds of launching; locking that file to stop the overwrite
makes Mail show a blank signature instead). There is no reliable way
to force true side-by-side into Mail's own signature storage.

Two options:

1. **Stacked layout via the normal Signature pane** — paste
   `signature.html` in the same way as iPhone (Safari → Select All →
   Copy → Mail → Settings → Signatures → paste). Logo ends up above
   the text instead of beside it, but fonts/colors/links/logo are all
   correct.
2. **True side-by-side via a third-party signature manager** (e.g.
   Email Signature Rescue, Exclaimer, CodeTwo) — these inject the
   signature outside of Mail's own storage, bypassing the limitation
   entirely. `signature.html` is already in the self-contained format
   these tools expect (no external image dependency), so it should
   import cleanly into whichever one you choose. Setting up the
   third-party app/account itself is a manual step outside of what
   can be done here.
