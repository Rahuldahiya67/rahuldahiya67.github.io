#!/usr/bin/env bash
# Rebuild assets/Rahul_Dahiya_Resume.pdf from resume/resume.html with headless Chromium.
# Needs the Carlito font (fonts-crosextra-carlito) so the layout matches. Prints the page count.
set -euo pipefail
cd "$(dirname "$0")/.."
CHROME="${CHROME:-$(command -v chromium || command -v chromium-browser || command -v google-chrome || echo /opt/pw-browsers/chromium)}"
"$CHROME" --headless --no-sandbox --disable-gpu --no-pdf-header-footer \
  --print-to-pdf=assets/Rahul_Dahiya_Resume.pdf "file://$PWD/resume/resume.html" 2>/dev/null
python3 - <<'PY'
from pypdf import PdfReader
n = len(PdfReader("assets/Rahul_Dahiya_Resume.pdf").pages)
print(f"pages: {n}")
if n > 2:
    raise SystemExit("resume is longer than two pages")
PY
