# Seth Plunkett — HTML Email Signature (Apple Mail / iPhone)

Matches the MasTec Utility Services desktop signature (name, title, logo,
divider, contact block), self-contained with the logo embedded as base64
so it always displays — no external image hosting required.

- `signature.html` — the finished, ready-to-use signature (open & copy this one).
- `template.html` — same markup with `{{LOGO_SRC}}` unfilled, in case you need to swap the logo image later.
- `assets/mastec-logo.png` — the source logo file used to build `signature.html`.

## Install on iPhone (Mail app)

iOS Mail's Settings screen only accepts plain text, but it *will* keep rich
formatting (fonts, colors, the logo image, links) if you paste it in from
Safari. This is the standard trick for getting an HTML signature onto iPhone
without a Mac:

1. On your iPhone, open **Safari** and browse to `signature.html`. Easiest
   way to get it there:
   - Save it to **iCloud Drive / Files**, then open it from the Files app
     (it opens in Safari), **or**
   - Open the raw file link from this GitHub branch in Safari, **or**
   - AirDrop the file to your iPhone and open with Safari.
2. Once it's rendered in Safari, tap and hold anywhere in the signature
   block → **Select All** → **Copy**. (Make sure you copy the whole block,
   including the logo.)
3. Go to **Settings → Mail → Signature**.
4. If you have multiple email accounts, tap **Per Account** and pick the
   signature box under **Seth.Plunkett@mastec.com**.
5. Tap into the signature text box, **tap and hold → Paste**.
6. The logo, divider line, bold name/title, and the two dark-blue contact
   lines (with the website + email underlined as tappable links) should all
   appear. Send yourself a test email to confirm.

If Mail ever strips the logo image on paste, re-open `signature.html` in
Safari and repeat the copy/paste — the image is embedded directly in the
HTML (as a base64 data URI), so nothing needs to load from the internet.

## Install on Mac (Apple Mail)

1. Open `signature.html` in Safari.
2. Select All → Copy.
3. **Mail → Settings → Signatures**, select the `Seth.Plunkett@mastec.com`
   account, create a new signature, click into the body, and Paste.
4. Uncheck "Always match my default message font" so the signature keeps
   its own fonts/colors.

Because Mail signatures sync via iCloud when **Settings → Mail →
Signature** is set to "All Signatures" / synced, doing this once on Mac
can also push it to your iPhone automatically — worth trying first if you
have both devices.
