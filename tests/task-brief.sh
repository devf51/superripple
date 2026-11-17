#!/usr/bin/env bash
# Self-check for skills/subagent-driven-development/scripts/task-brief:
# Thai ("งานที่ N") and English ("Task N") headings both split a plan into tasks.
# Usage: tests/task-brief.sh
set -euo pipefail
tb="$(cd "$(dirname "$0")/.." && pwd)/skills/subagent-driven-development/scripts/task-brief"
t=$(mktemp -d); trap 'rm -rf "$t"' EXIT
fail=0
check() { if eval "$2"; then echo "ok   $1"; else echo "FAIL $1"; fail=1; fi; }

cat > "$t/thai.md" <<'P'
# แผน
### งานที่ 1: Parser
body-one
#### งานที่ 1a: sub
body-sub
### งานที่ 2: Writer
body-two
P
cat > "$t/en.md" <<'P'
### Task 1: A
en-one
### Task 2: B
en-two
P
printf '## Tarea 1: x\n' > "$t/es.md"

"$tb" "$t/thai.md" 1 "$t/o1" >/dev/null
check "thai task 1 keeps its body and subtask" 'grep -q body-one "$t/o1" && grep -q body-sub "$t/o1" && ! grep -q body-two "$t/o1"'
"$tb" "$t/thai.md" 2 "$t/o2" >/dev/null
check "thai task 2 stands alone" 'grep -q body-two "$t/o2" && ! grep -q body-one "$t/o2"'
"$tb" "$t/en.md" 2 "$t/o3" >/dev/null
check "english task 2 still works" 'grep -q en-two "$t/o3" && ! grep -q en-one "$t/o3"'
rc=0; "$tb" "$t/es.md" 1 "$t/o4" >/dev/null 2>"$t/err" || rc=$?
check "untranslatable heading still fails with exit 3" '[ "$rc" = 3 ] && grep -q "Tarea 1" "$t/err"'
exit "$fail"
