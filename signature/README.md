# Seth Plunkett — HTML Email Signature (Apple Mail — Mac & iPhone)

Matches the MasTec Utility Services desktop signature (name, title, logo,
divider, contact block), self-contained with the logo embedded as base64
so it always displays — no external image hosting required.

- `signature.html` — the finished, ready-to-use signature (open & copy this one).
- `template.html` — same markup with `{{LOGO_SRC}}` unfilled, in case you need to swap the logo image later.
- `assets/mastec-logo.png` — the original full-resolution source logo.
- `assets/mastec-logo-small.png` — the logo pre-resized to 200×77px (the copy actually embedded in `signature.html`); see the Mac section below for why.
- `mac-direct-install/install-mac-signature.sh` — one-shot script that installs the true side-by-side layout directly into macOS Mail's signature file, bypassing the GUI editor's stacked-layout limitation (see below).

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

⚠️ **Read this first:** Apple Mail's Signature preference pane (the normal
copy/paste-into-the-GUI method below) does **not** support side-by-side
layouts. It stores signatures as simplified rich text, not full HTML/CSS —
so a table with the logo on the left and text on the right always gets
flattened into a stacked column (logo on its own line, then the text block
below), no matter how the HTML is written. This is a hard limitation of
the editor itself, not a bug in this file.

- If a **stacked** result (logo above the text) is fine, use the **GUI
  method** just below — it's simpler and the safest way to get *something*
  working. (Also good on any earlier stacked version's next paste!)
- If you want the **exact desktop side-by-side layout**, skip to
  **[True side-by-side layout](#true-side-by-side-layout-direct-file-install)**
  below — it edits Mail's underlying signature file directly to get around
  the GUI's limitation.

### GUI method (paste into Mail's Signature pane — always stacks)

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
   `Seth.Plunkett@mastec.com`.
8. Compose a new test email — logo will appear above the text block, not
   beside it (see caveat above). Fonts, colors, and the underlined
   website/email links should still all be correct.

The logo image is also pre-sized to its true on-screen dimensions
(200×77px) rather than scaled with CSS — this matters because Mail's
compose window has its own **"Image Size"** control (top-right, next to
"Message Size") that re-scales any pasted image based on the image file's
*own* pixel dimensions, ignoring width/height set in HTML/CSS. Baking the
real size into the file itself means Mail's "Actual Size" setting already
shows it correctly, instead of blowing it back up to a huge 2281×877.

### True side-by-side layout (direct file install)

This gets the exact desktop-matching side-by-side layout (logo | divider |
name/title/contact) by editing Mail's own signature file on disk directly,
bypassing the Signature pane's editor entirely — since that file *is* real
HTML, Mail renders it correctly even though its GUI editor can't create it.

Everything you need is in `mac-direct-install/install-mac-signature.sh` —
a single, self-contained script (the signature HTML is embedded inside it,
nothing else to download).

0. **Grant Terminal Full Disk Access first.** macOS treats `~/Library/Mail`
   as protected user data (TCC privacy protection) — Terminal can't read
   it by default even though it's your own account. Without this, the
   script will report finding nothing at all. **System Settings → Privacy
   & Security → Full Disk Access → +** → add Terminal.app (or iTerm2 /
   whatever you run the script from) → make sure its toggle is on → fully
   quit and reopen the terminal app.
1. **Create a placeholder signature the normal way** — follow the
   GUI method above once (any content is fine, even just typing "Seth")
   so Mail creates the signature file and links it to
   `Seth.Plunkett@mastec.com`. This script only edits an *existing* file;
   it won't create the account association for you.
2. **Quit Mail completely** (**Mail → Quit Mail**, or ⌘Q — not just
   closing the window).
3. **Check for iCloud Mail signature sync.** If you sync Mail settings via
   iCloud, a sync pass can silently revert this script's changes back to
   the old GUI version. Look under **System Settings → [your name] →
   iCloud → Saved to iCloud → Mail**, and consider turning it off until
   you've confirmed the new signature looks right — then it's safe to turn
   back on, since the synced copy will now match what's in Mail.
4. Get `mac-direct-install/install-mac-signature.sh` onto your Mac (open
   the raw file link from this branch on GitHub in Safari and Save As…,
   or AirDrop it, or `git clone` the repo).
5. Open **Terminal**, then:
   ```
   chmod +x ~/Downloads/install-mac-signature.sh
   ~/Downloads/install-mac-signature.sh
   ```
   (adjust the path if you saved it somewhere other than Downloads)
6. Read the script's output:
   - It searches `~/Library/Mail/V*/MailData/Signatures` for the
     `.mailsignature` file containing "Seth Plunkett" and the phone
     number, to make sure it edits the right one.
   - It backs up the original file next to itself first
     (`<name>.mailsignature.bak.<timestamp>`) before changing anything.
   - It replaces only the inner content, leaving Mail's own file wrapper
     intact.
   - If it finds **zero** matches, you likely skipped step 1 (or quit
     without saving the placeholder signature) — go back and do that
     first.
   - If it finds **more than one** match, delete the extra/duplicate
     signature in Mail's Signatures pane first so only one remains, then
     re-run.
7. **Reopen Mail** and compose a new test email — the logo, divider, and
   text should now sit side by side, matching the desktop signature
   exactly. (The Signatures *preference pane's* own preview may still show
   it stacked — that preview widget has the same rich-text limitation
   described above; it doesn't reflect what actually gets inserted into a
   real message, so trust a real compose window over that preview.)

**To undo:** quit Mail, copy the `.bak.<timestamp>` file back over the
`.mailsignature` file it came from, relaunch Mail.

**Bonus:** if **Settings → Mail → Signature** on your iPhone is not
grayed out and shows the option, macOS Mail signatures set up this way
sync via iCloud automatically — so doing it here first may save you the
copy/paste on the phone entirely. If it doesn't sync (Apple doesn't always
sync signatures across devices), just follow the iPhone steps above with
the same file.
