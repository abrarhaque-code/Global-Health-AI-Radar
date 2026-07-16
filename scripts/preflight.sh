#!/usr/bin/env bash
#
# preflight.sh: hygiene checks for the AI x Global Health Radar repository.
#
# Run from the repository root:
#   bash scripts/preflight.sh
#
# Optional deep scan:
#   bash scripts/preflight.sh --history
# additionally sweeps the full git history for banned tokens. Run it once
# before making a previously private repository public, or after adding new
# tokens to private/banned_tokens.txt.
#
# Each check prints a PASS or FAIL line. The script exits nonzero if any
# check FAILs. WARN lines do not affect the exit code.
#
# Design note: this script deliberately excludes the scripts/ directory from
# the prose and banned-token scans so it does not flag its own pattern text.
# The punctuation scan uses perl-regex \x{...} escapes (not literal
# characters) for the same reason.

set -euo pipefail

HISTORY_MODE=0
[ "${1:-}" = "--history" ] && HISTORY_MODE=1

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
# Check (b): no banned tokens. The default list contains only a generic
# sentinel marker: tag any draft content you must never commit with
# DO_NOT_COMMIT and this check will catch it.
#
# Add your own confidential tokens (firm names, portfolio companies, internal
# program names, codenames, legacy field names) to private/banned_tokens.txt,
# one per line, '#' comments allowed. That file lives in the gitignored
# private/ directory, so the token list itself never becomes public.
# Case-insensitive, whole-word, fixed-string match.
# ---------------------------------------------------------------------------
BANNED_TOKENS=(DO_NOT_COMMIT)

BANNED_TOKENS_FILE="private/banned_tokens.txt"
if [ -f "$BANNED_TOKENS_FILE" ]; then
  while IFS= read -r line; do
    line="${line%%#*}"
    line="$(printf '%s' "$line" | tr -d '[:space:]')"
    [ -n "$line" ] && BANNED_TOKENS+=("$line")
  done < "$BANNED_TOKENS_FILE"
fi

if [ ${#existing_targets[@]} -eq 0 ]; then
  warn "banned-token scan: no scan targets present yet, skipping"
else
  banned_found=0
  for tok in "${BANNED_TOKENS[@]}"; do
    # -i case-insensitive, -w whole word, -F fixed string, -l filenames only.
    tok_hits=$(grep -rilwF "$tok" "${existing_targets[@]}" 2>/dev/null || true)
    if [ -n "$tok_hits" ]; then
      fail "banned token '$tok' found in:"
      printf '        %s\n' $tok_hits
      banned_found=1
    fi
  done
  if [ "$banned_found" -eq 0 ]; then
    pass "banned tokens: none found (${#BANNED_TOKENS[@]} token(s) scanned)"
  fi
fi

# ---------------------------------------------------------------------------
# Optional history scan (--history): banned tokens must be absent from every
# commit, not just the working tree. A hit here means the repository needs a
# history rewrite before it can be shared.
# ---------------------------------------------------------------------------
if [ "$HISTORY_MODE" -eq 1 ]; then
  if git rev-parse --git-dir >/dev/null 2>&1; then
    hist_found=0
    for tok in "${BANNED_TOKENS[@]}"; do
      hist_hits=$(git log --all -i --pickaxe-regex -S"$tok" --format='%h %s' -- . ':(exclude)scripts' 2>/dev/null || true)
      if [ -n "$hist_hits" ]; then
        fail "banned token '$tok' appears in git history (needs history rewrite):"
        printf '        %s\n' "$hist_hits"
        hist_found=1
      fi
    done
    [ "$hist_found" -eq 0 ] && pass "history: no banned tokens in any commit"
  else
    warn "history scan requested but not a git repository, skipping"
  fi
fi

# ---------------------------------------------------------------------------
# Check (c): WARN (not fail) if a company card lacks a sources: line.
# Excludes _watchlist.md, which is a table, not a card.
# ---------------------------------------------------------------------------
if [ -d landscape/companies ]; then
  missing_sources=0
  for card in landscape/companies/*.md; do
    [ -e "$card" ] || continue
    base=$(basename "$card")
    case "$base" in
      _watchlist.md) continue ;;
    esac
    if ! grep -q '^sources:' "$card"; then
      warn "company card missing 'sources:' line: $card"
      missing_sources=1
    fi
  done
  if [ "$missing_sources" -eq 0 ]; then
    pass "sources: all company cards declare sources"
  fi
else
  warn "sources scan: landscape/companies not present, skipping"
fi

# ---------------------------------------------------------------------------
# Check (d): .gitignore must contain a private/ line.
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
