#!/usr/bin/env bash
#
# preflight.sh: hygiene checks for the AI x Global Health Radar repository.
#
# Run from the repository root:
#   bash scripts/preflight.sh
#
# Each check prints a PASS or FAIL line. The script exits nonzero if any
# check FAILs. WARN lines do not affect the exit code.
#
# Design note: this script deliberately excludes the scripts/ directory from
# the prose and banned-token scans so it does not flag its own pattern text or
# the banned-token list defined below. The punctuation scan uses perl-regex
# \x{...} escapes (not literal characters) for the same reason.

set -euo pipefail

# Track overall status. Any FAIL flips this to 1.
status=0

pass() { printf 'PASS  %s\n' "$1"; }
fail() { printf 'FAIL  %s\n' "$1"; status=1; }
warn() { printf 'WARN  %s\n' "$1"; }

# Directories and files to scan for prose rules. The scripts/ directory is
# intentionally omitted (see design note above). Missing paths are skipped so
# the script is usable before every file exists.
SCAN_TARGETS=(docs prompts taxonomy memos landscape outreach README.md CLAUDE.md CONTRIBUTING.md)

# Build the list of scan targets that actually exist on disk.
existing_targets=()
for t in "${SCAN_TARGETS[@]}"; do
  if [ -e "$t" ]; then
    existing_targets+=("$t")
  fi
done

# ---------------------------------------------------------------------------
# Check (a): no em dash (U+2014) or ellipsis (U+2026) in prose.
# ---------------------------------------------------------------------------
if [ ${#existing_targets[@]} -eq 0 ]; then
  warn "punctuation scan: no scan targets present yet, skipping"
else
  # grep -r recurse, -l list filenames, -P perl regex. \x{2014} em dash,
  # \x{2026} ellipsis. We list offending files so they are easy to fix.
  punct_hits=$(grep -rlP '\x{2014}|\x{2026}' "${existing_targets[@]}" 2>/dev/null || true)
  if [ -n "$punct_hits" ]; then
    fail "punctuation: em dash or ellipsis found in:"
    printf '        %s\n' $punct_hits
  else
    pass "punctuation: no em dash or ellipsis in prose"
  fi
fi

# ---------------------------------------------------------------------------
# Check (b): the field name adjuvant_fit_rating must not appear anywhere.
# The schema field is fit_rating.
# ---------------------------------------------------------------------------
if [ ${#existing_targets[@]} -eq 0 ]; then
  warn "fit_rating field scan: no scan targets present yet, skipping"
else
  legacy_field_hits=$(grep -rl 'adjuvant_fit_rating' "${existing_targets[@]}" 2>/dev/null || true)
  if [ -n "$legacy_field_hits" ]; then
    fail "schema: legacy field name found (use fit_rating) in:"
    printf '        %s\n' $legacy_field_hits
  else
    pass "schema: no legacy fit-rating field name"
  fi
fi

# ---------------------------------------------------------------------------
# Check (c): no banned real-world tokens. These are firm names, portfolio
# names, and real companies that must not leak into the public template.
# Case-insensitive, whole-word match.
# ---------------------------------------------------------------------------
BANNED_TOKENS=(adjuvant aghaf malaica yemaachi 54gene deepecho minohealth nawah bamco tricog penda rology newtopia babylon)

if [ ${#existing_targets[@]} -eq 0 ]; then
  warn "banned-token scan: no scan targets present yet, skipping"
else
  banned_found=0
  for tok in "${BANNED_TOKENS[@]}"; do
    # -i case-insensitive, -w whole word, -l filenames only.
    tok_hits=$(grep -rilw "$tok" "${existing_targets[@]}" 2>/dev/null || true)
    if [ -n "$tok_hits" ]; then
      fail "banned token '$tok' found in:"
      printf '        %s\n' $tok_hits
      banned_found=1
    fi
  done
  if [ "$banned_found" -eq 0 ]; then
    pass "banned tokens: none found"
  fi
fi

# ---------------------------------------------------------------------------
# Check (d): WARN (not fail) if a company card lacks a sources: line.
# Excludes _watchlist.md and EXAMPLE-* scaffolding files.
# ---------------------------------------------------------------------------
if [ -d landscape/companies ]; then
  missing_sources=0
  for card in landscape/companies/*.md; do
    [ -e "$card" ] || continue
    base=$(basename "$card")
    case "$base" in
      _watchlist.md) continue ;;
      EXAMPLE-*) continue ;;
    esac
    if ! grep -q '^sources:' "$card"; then
      warn "company card missing 'sources:' line: $card"
      missing_sources=1
    fi
  done
  if [ "$missing_sources" -eq 0 ]; then
    pass "sources: all non-example company cards declare sources"
  fi
else
  warn "sources scan: landscape/companies not present, skipping"
fi

# ---------------------------------------------------------------------------
# Check (e): .gitignore must contain a private/ line.
# ---------------------------------------------------------------------------
if [ -f .gitignore ]; then
  if grep -qE '^private/' .gitignore; then
    pass "gitignore: private/ is ignored"
  else
    fail "gitignore: missing a 'private/' line"
  fi
else
  fail "gitignore: .gitignore not found"
fi

# ---------------------------------------------------------------------------
# Summary and exit.
# ---------------------------------------------------------------------------
echo
if [ "$status" -eq 0 ]; then
  echo "preflight: ALL CHECKS PASSED"
else
  echo "preflight: ONE OR MORE CHECKS FAILED"
fi
exit "$status"
