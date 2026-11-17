# Changelog

What changed in each release of the shared rules, newest first. Versions are git tags (`v1.2.0`) made by `make release`; see [Versioning](README.md#versioning) for when to bump which part.

Add a line under **Unreleased** in the same commit as the change. `make release` refuses to run while Unreleased is empty, then renames it to the new version and date.

## Unreleased

- Backlog priorities are p0 to p5; p5 is the icebox, skipped by work and groom and only counted by list.
- Design principle 13: prefer clear, familiar, monochrome icons over text; no emoji icons.
- Frontend suggests the volta component library.
- Hover may resize an element if its hover/click mask stays the same.
- Native: `make install-open` closes the running app and reopens it; macOS app builds go in `build/`, not `.build/`.
- Native in prototyping mode: tests run locally after each commit and in CI; CI tests and builds apps only on release tags.
- This repo keeps a changelog, `make release` stamps it, and major bumps are for rule changes agents rely on.

## v1.4.0 (2026-11-08)

- Backlog write and groom ask clickable multiple-choice questions.
- Backlog mode pushes every backlog branch from creation, finished or not.
- Prototyping mode rebase-merges finished backlog branches, then deletes them.

## v1.3.0 (2026-11-08)

- Ask the user one question at a time.
- Backlog special commands: write, groom, list, work.
- Design principle 12: buttons with icons.

## v1.2.0 (2026-11-05)

- Animation lengths.
- Rebase-merge branches; backlog branches in prototyping mode; MVCS.

## v1.1.0 (2026-10-30)

- The rules are versioned by git tags; `make release` and `make version`.

## v1.0.0 (2026-10-30)

- First release: shared rules and the agent-rules CLI, pulled from inertia, pocketproducer-web, ironyoung-web and paulandvaos.
