# Seth Plunkett — HTML Email Signature (Apple Mail — Mac & iPhone)

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

This is the same `signature.html` used for iPhone — nothing to redesign,
just a different (easier) install path since the Mac lets you paste
straight into the Mail app itself.

1. **Open `signature.html` in Safari** (double-click the file, or drag it
   onto the Safari icon).
2. Click anywhere in the signature block, then **Edit → Select All**
   (⌘A) → **Edit → Copy** (⌘C).
3. Open **Mail**, then from the menu bar: **Mail → Settings…** (called
   **Mail → Preferences…** on macOS versions before Ventura) → **Signatures**
   tab.
4. In the left column, select the **Seth.Plunkett@mastec.com** account
   (or the "All Signatures" list if you keep it there).
5. Click the **+** button to add a new signature, give it a name (e.g.
   "MasTec"), then click into the empty preview pane on the right and
   **Paste** (⌘V).
6. Uncheck **"Always match my default message font"** at the bottom —
   otherwise Mail overrides the signature's fonts/colors with your default
   compose font.
7. Still on the Signatures tab, use the **"Choose Signature"** dropdown
   under the account list to set this new signature as the default for
   `Seth.Plunkett@mastec.com` (or set it to "At Random"/"In Sequential
   Order" only if you want it mixed with others — for a single consistent
   signature, pick it directly by name).
8. Compose a new test email to confirm the logo, divider, bold name/title,
   and the underlined website/email links all render correctly.

**Bonus:** if **Settings → Mail → Signature** on your iPhone is not
grayed out and shows the option, macOS Mail signatures set up this way
sync via iCloud automatically — so doing it here first may save you the
copy/paste on the phone entirely. If it doesn't sync (Apple doesn't always
sync signatures across devices), just follow the iPhone steps above with
the same file.
