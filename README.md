# superripple

A skills library for Claude Code, forked from [superpowers](https://github.com/obra/superpowers) by Jesse Vincent. The skills are translated into Thai and the workflow adds a design step:

brainstorming (spec) → design (design doc) → writing-plans (plan) → subagent-driven-development or executing-plans → finishing-a-development-branch

Added skills: `design`, `codebase-design`, `backend-architect`, `database-architect`, `impeccable` (frontend design), `security-audit`.

## Install

```
/plugin marketplace add devf51/superripple
/plugin install superripple@superripple-dev
```

**If you also have the original superpowers plugin, disable it first.** Both plugins use the same skill names (brainstorming, writing-plans, …) and store files in different places, so running both mixes the two workflows:

```
claude plugin disable superpowers@superpowers-marketplace
```

## Notes

- `impeccable` downloads its engine binary from the impeccable GitHub releases on first use and checks it against the SHA-256 sums in `skills/impeccable/scripts/engine-checksums.txt`.
- Plans may use either `### Task N:` or `### งานที่ N:` headings; the plan scripts accept both. Self-check: `tests/task-brief.sh`.

## License

MIT, see [LICENSE](LICENSE). `skills/impeccable` (Apache 2.0) and `skills/security-audit` (MIT, Cloudflare) carry their own licenses.
