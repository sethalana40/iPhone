#!/bin/bash
# ============================================================================
# Seth Plunkett — MasTec Utility Services — direct .mailsignature installer
#
# WHY THIS EXISTS
#   Apple Mail's Signature preference pane (Mail > Settings > Signatures)
#   stores signatures as simplified rich text, not full HTML/CSS. Pasting a
#   table-based side-by-side layout (logo | divider | name/title/contact)
#   into that editor gets flattened into stacked paragraphs — there is no
#   way around that through the GUI.
#
#   Mail's signatures ARE stored on disk as real HTML files though
#   (~/Library/Mail/V*/MailData/Signatures/<uuid>.mailsignature). This
#   script finds the file for your existing "Seth" signature and swaps its
#   inner content for the full table-based HTML, bypassing the GUI editor's
#   limitations entirely.
#
# BEFORE RUNNING THIS
#   1. In Mail: Mail > Settings… > Signatures, make sure a signature already
#      exists and is assigned to Seth.Plunkett@mastec.com (any placeholder
#      text is fine — this script only needs the file + account link to
#      already exist).
#   2. Completely quit Mail (Mail menu > Quit Mail, or Cmd+Q — not just
#      closing the window).
#   3. If you use iCloud to sync Mail signatures (System Settings > [your
#      name] > iCloud > Saved to iCloud > Mail, or an "Internet Accounts"
#      toggle for iCloud Mail sync), consider turning that off first — a
#      sync pass can overwrite this script's changes with the old GUI
#      version. You can turn it back on after confirming the signature
#      looks right and has synced once.
#
# WHAT THIS SCRIPT DOES
#   - Searches ~/Library/Mail/V*/MailData/Signatures for a .mailsignature
#     file containing both "Seth Plunkett" and "336-509-5815" (to uniquely
#     identify the right one if you have several signatures).
#   - Backs up the original file next to itself as <name>.bak.<timestamp>.
#   - Replaces everything between the file's <body ...> and </body> tags
#     with the MasTec table layout, keeping Mail's own outer wrapper intact.
#   - If no <body> tag is found, wraps the whole file in a fresh minimal
#     HTML document instead.
#
# HOW TO RUN
#   1. Save this file somewhere on your Mac (e.g. Downloads).
#   2. Open Terminal.
#   3. chmod +x ~/Downloads/install-mac-signature.sh
#   4. ~/Downloads/install-mac-signature.sh
#   5. Read the output. Then reopen Mail and check a new compose window.
#
# UNDOING
#   Every original file is backed up next to itself before being touched.
#   To revert: quit Mail, copy the .bak.<timestamp> file back over the
#   .mailsignature file it came from, relaunch Mail.
# ============================================================================

set -euo pipefail
shopt -s nullglob

echo "Looking for your MasTec signature file under ~/Library/Mail ..."

# Find every V<N>/MailData/Signatures directory (avoids assuming a specific
# macOS/Mail version), then check each .mailsignature file's contents with
# plain `grep -q` (portable across the BSD grep macOS ships and GNU grep).
SIG_DIRS=("$HOME"/Library/Mail/V*/MailData/Signatures)

CANDIDATES=()
for d in "${SIG_DIRS[@]}"; do
  [ -d "$d" ] || continue
  while IFS= read -r -d '' f; do
    CANDIDATES+=("$f")
  done < <(find "$d" -maxdepth 1 -type f -name "*.mailsignature" -print0 2>/dev/null)
done

MATCHES=()
for f in "${CANDIDATES[@]}"; do
  if grep -q "Seth Plunkett" "$f" 2>/dev/null && grep -q "336-509-5815" "$f" 2>/dev/null; then
    MATCHES+=("$f")
  fi
done

if [ "${#MATCHES[@]}" -eq 0 ]; then
  echo "No matching .mailsignature file found."
  echo "Make sure you've created a placeholder 'Seth' signature in Mail > Settings > Signatures first, then quit Mail and re-run this script."
  exit 1
fi

if [ "${#MATCHES[@]}" -gt 1 ]; then
  echo "Found more than one matching signature file — not sure which to edit:"
  printf '  %s\n' "${MATCHES[@]}"
  echo "Please delete the extra/old signature in Mail's Signatures pane (so only one 'Seth' signature remains), quit Mail, and re-run this script."
  exit 1
fi

TARGET="${MATCHES[0]}"
STAMP=$(date +%Y%m%d-%H%M%S)
BACKUP="${TARGET}.bak.${STAMP}"

echo "Found: $TARGET"
echo "Backing up to: $BACKUP"
cp "$TARGET" "$BACKUP"

NEW_BODY=$(cat <<'MASTEC_SIG_BODY_EOF'
<table role="presentation" width="620" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse;table-layout:fixed;font-family:Helvetica Neue, Helvetica, Arial, sans-serif;background:#ffffff;">
  <tr>
    <!-- Logo (image file itself is pre-sized to 200x77px so Apple Mail's
         own "Image Size" compose-time scaling — which ignores CSS/HTML
         width/height on pasted images — can't blow it back up) -->
    <td width="222" style="width:222px;padding:0 22px 0 0;vertical-align:middle;white-space:nowrap;" valign="middle">
      <img src="data:image/png;base64,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" width="200" height="77" alt="MasTec Utility Services" style="display:block;border:0;outline:none;width:200px;height:77px;">
    </td>
    <!-- Divider -->
    <td width="23" style="width:23px;padding:0 22px 0 0;border-left:1px solid #c8c8c8;font-size:1px;line-height:1px;white-space:nowrap;" valign="middle">&nbsp;</td>
    <!-- Details -->
    <td style="vertical-align:middle;white-space:nowrap;" valign="middle">
      <table role="presentation" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse;">
        <tr>
          <td style="font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:21px;line-height:26px;font-weight:bold;color:#58595B;padding:0;">
            Seth Plunkett
          </td>
        </tr>
        <tr>
          <td style="font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:16px;line-height:21px;font-weight:bold;color:#58595B;padding:0 0 8px 0;">
            Project Manager Carolinas, Mastec Energy Solutions
          </td>
        </tr>
        <tr>
          <td style="font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:14px;line-height:22px;font-weight:normal;color:#2E3B55;padding:0;">
            Distribution, Transmission, and Substation
          </td>
        </tr>
        <tr>
          <td style="font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:14px;line-height:22px;font-weight:normal;color:#2E3B55;padding:0;">
            336-509-5815&nbsp;&nbsp;|&nbsp;&nbsp;<a href="https://www.mastec.com" style="color:#2E3B55;text-decoration:underline;">www.mastec.com</a>
          </td>
        </tr>
        <tr>
          <td style="font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:14px;line-height:22px;font-weight:normal;color:#2E3B55;padding:0;">
            <a href="mailto:seth.plunkett@mastec.com" style="color:#2E3B55;text-decoration:underline;">seth.plunkett@mastec.com</a>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
MASTEC_SIG_BODY_EOF
)

python3 - "$TARGET" "$NEW_BODY" <<'PYEOF'
import re, sys

target_path = sys.argv[1]
new_body = sys.argv[2]

with open(target_path, "r", encoding="utf-8", errors="surrogateescape") as f:
    content = f.read()

pattern = re.compile(r"(<body[^>]*>)(.*)(</body>)", re.DOTALL | re.IGNORECASE)
m = pattern.search(content)

if m:
    new_content = content[:m.start()] + m.group(1) + new_body + m.group(3) + content[m.end():]
else:
    # No <body> tag found — wrap the whole thing fresh.
    new_content = (
        "<html><body style=\"overflow-wrap: break-word; -webkit-nbsp-mode: space; "
        "line-break: after-white-space;\">" + new_body + "</body></html>"
    )

with open(target_path, "w", encoding="utf-8", errors="surrogateescape") as f:
    f.write(new_content)

print("Wrote new signature content into:", target_path)
PYEOF

echo ""
echo "Done. Now:"
echo "  1. Reopen Mail."
echo "  2. Mail > Settings… > Signatures — confirm the 'Seth' signature still shows"
echo "     (the preview pane there may still render it flattened/stacked — that's"
echo "     just a limitation of the preview widget, it does NOT reflect what gets"
echo "     inserted into a real message)."
echo "  3. Compose a new email and confirm the logo, divider, and text sit side by side."
echo "  4. If it reverts later, iCloud signature sync likely overwrote it —"
echo "     turn that sync off, then re-run this script."
