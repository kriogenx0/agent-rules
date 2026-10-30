#!/usr/bin/env bash
# Exercises bin/agent-rules end to end. Everything happens in a temp
# directory: a copy of this checkout (so tests can change rules/ freely),
# throwaway repos, and a throwaway HOME for the global install. Nothing under
# your real ~/.claude, ~/.codex or ~/Sites is touched.
set -uo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

AR="$WORK/agent-rules"
mkdir -p "$AR"
cp -R "$SRC/bin" "$SRC/docs" "$SRC/global" "$SRC/templates" "$AR/"
git -C "$AR" init -q && git -C "$AR" add -A && git -C "$AR" -c user.name=t -c user.email=t@t commit -qm init
CLI="$AR/bin/agent-rules"
export CLAUDE_HOME="$WORK/home/.claude" CODEX_HOME="$WORK/home/.codex"

PASS=0 FAIL=0
ok() { PASS=$((PASS + 1)); }
bad() { FAIL=$((FAIL + 1)); echo "FAIL: $*"; }
expect() { local desc="$1"; shift; if "$@" >/dev/null 2>&1; then ok; else bad "$desc"; fi; }
expect_not() { local desc="$1"; shift; if "$@" >/dev/null 2>&1; then bad "$desc"; else ok; fi; }
count() { grep -cF -- "$1" "$2" 2>/dev/null || echo 0; }
nrules() { ls "$AR"/docs/rules/*.md | wc -l | tr -d ' '; }

# ── install into a fresh repo ──
R="$WORK/repo"; mkdir -p "$R"
expect "install into a fresh repo succeeds" "$CLI" install "$R"
expect "AGENTS.md created" test -f "$R/AGENTS.md"
expect "CLAUDE.md imports AGENTS.md" grep -qx "@AGENTS.md" "$R/CLAUDE.md"
expect "docs/project created" test -d "$R/docs/project"
expect "settings.md created from the template" diff "$AR/templates/settings.md" "$R/docs/project/settings.md"
expect "AGENTS.md loads the project settings" grep -qx "@docs/project/settings.md" "$R/AGENTS.md"
[ "$(grep -m1 '^@docs/rules/' "$R/AGENTS.md")" = "@docs/rules/project-settings.md" ] && ok || bad "project-settings.md loads first"
[ "$(ls "$R"/docs/rules/*.md | wc -l | tr -d ' ')" = "$(nrules)" ] && ok || bad "every rule synced"
expect "synced files carry a header" grep -q "agent-rules:synced" "$R/docs/rules/backlog.md"
expect "synced body matches upstream" diff <(tail -n +2 "$R/docs/rules/backlog.md") "$AR/docs/rules/backlog.md"
[ "$(count "@docs/rules/" "$R/AGENTS.md")" = "$(nrules)" ] && ok || bad "loader imports every rule"
expect "Makefile has a rules target" grep -q "^rules:" "$R/Makefile"
expect "make rules works from the repo" make -C "$R" rules AGENT_RULES="$AR"
expect "check is clean right after install" "$CLI" check "$R"

# ── reinstall is idempotent ──
"$CLI" install "$R" >/dev/null 2>&1
[ "$(grep -c '^rules:' "$R/Makefile")" = 1 ] && ok || bad "reinstall doesn't duplicate the make target"
[ "$(count "@docs/rules/backlog.md" "$R/AGENTS.md")" = 1 ] && ok || bad "reinstall doesn't duplicate loader lines"

# ── a local edit is never silently overwritten ──
echo "local tweak" >> "$R/docs/rules/backlog.md"
expect_not "check flags a local edit" "$CLI" check "$R"
expect_not "sync refuses to overwrite a local edit" "$CLI" sync "$R"
expect "the edit survives a refused sync" grep -q "local tweak" "$R/docs/rules/backlog.md"
FORCE=1 "$CLI" sync "$R" >/dev/null 2>&1
expect_not "FORCE=1 discards the edit" grep -q "local tweak" "$R/docs/rules/backlog.md"

# ── upstream changes flow down ──
echo "- new upstream line" >> "$AR/docs/rules/conventions.md"
git -C "$AR" -c user.name=t -c user.email=t@t commit -qam change
expect_not "check reports an outdated rule" "$CLI" check "$R"
"$CLI" sync "$R" >/dev/null 2>&1
expect "sync pulls the upstream change" grep -q "new upstream line" "$R/docs/rules/conventions.md"
expect "header records the new commit" grep -q "agent-rules@$(git -C "$AR" rev-parse --short HEAD) " "$R/docs/rules/conventions.md"

# ── new and removed upstream rules ──
printf '## Brand new\n' > "$AR/docs/rules/brand-new.md"
git -C "$AR" rm -q docs/rules/prototyping-mode.md
git -C "$AR" add -A && git -C "$AR" -c user.name=t -c user.email=t@t commit -qm add-remove
"$CLI" sync "$R" >/dev/null 2>&1
expect "new rule is synced" test -f "$R/docs/rules/brand-new.md"
expect "new rule is loaded" grep -qx "@docs/rules/brand-new.md" "$R/AGENTS.md"
expect_not "removed rule is deleted" test -e "$R/docs/rules/prototyping-mode.md"
expect_not "removed rule is no longer loaded" grep -q "prototyping-mode" "$R/AGENTS.md"

# ── a project file is never touched, even with a clashing name ──
P="$WORK/project-repo"; mkdir -p "$P/docs/rules"
printf '# mine\n' > "$P/docs/rules/backlog.md"
printf '# Existing\n@docs/rules/backlog.md\n' > "$P/AGENTS.md"
printf 'all:\n\techo hi\n' > "$P/Makefile"
expect_not "install reports the name clash" "$CLI" install "$P"
expect "project file is untouched" diff <(printf '# mine\n') "$P/docs/rules/backlog.md"
expect "existing AGENTS.md without markers is untouched" diff <(printf '# Existing\n@docs/rules/backlog.md\n') "$P/AGENTS.md"
expect "existing Makefile keeps its targets" grep -q "^all:" "$P/Makefile"
expect "existing Makefile gains rules" grep -q "^rules:" "$P/Makefile"
expect "other rules still sync" test -f "$P/docs/rules/conventions.md"
printf 'mine\n' > "$P/docs/project/settings.md"
"$CLI" install "$P" >/dev/null 2>&1
expect "an existing settings.md is never replaced" diff <(printf 'mine\n') "$P/docs/project/settings.md"

# ── sync-all only visits installed repos ──
U="$WORK/untouched"; mkdir -p "$U/docs/rules"; printf '# own\n' > "$U/docs/rules/x.md"
echo "- second upstream line" >> "$AR/docs/rules/conventions.md"
git -C "$AR" -c user.name=t -c user.email=t@t commit -qam change2
"$CLI" sync-all "$WORK" >/dev/null 2>&1
expect "sync-all updates installed repos" grep -q "second upstream line" "$R/docs/rules/conventions.md"
[ "$(ls "$U/docs/rules")" = "x.md" ] && ok || bad "sync-all leaves uninstalled repos alone"

# ── global install ──
mkdir -p "$CLAUDE_HOME"; printf 'My own note.\n' > "$CLAUDE_HOME/CLAUDE.md"
expect "install-global succeeds" "$CLI" install-global
expect "existing Claude text kept" grep -q "My own note." "$CLAUDE_HOME/CLAUDE.md"
expect "existing Claude file backed up" test -f "$CLAUDE_HOME/CLAUDE.md.before-agent-rules"
expect "Claude imports global rules" grep -qx "@$AR/global/preferences.md" "$CLAUDE_HOME/CLAUDE.md"
expect "Codex gets a copy" grep -q "Screenshots only when they earn it" "$CODEX_HOME/AGENTS.md"
"$CLI" install-global >/dev/null 2>&1
[ "$(count "agent-rules:begin" "$CLAUDE_HOME/CLAUDE.md")" = 1 ] && ok || bad "reinstall keeps one Claude block"
[ "$(count "agent-rules:begin" "$CODEX_HOME/AGENTS.md")" = 1 ] && ok || bad "reinstall keeps one Codex block"
expect "uninstall-global succeeds" "$CLI" uninstall-global
expect "uninstall keeps the user's own text" grep -q "My own note." "$CLAUDE_HOME/CLAUDE.md"
expect_not "uninstall removes the Claude block" grep -q "agent-rules" "$CLAUDE_HOME/CLAUDE.md"
expect_not "uninstall removes a Codex file that held only the block" test -e "$CODEX_HOME/AGENTS.md"

echo "$PASS passed, $FAIL failed"
[ "$FAIL" = 0 ]
