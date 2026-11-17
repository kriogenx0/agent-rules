# Changelog

What changed in each release of the shared rules, newest first. Versions are git tags (`v1.2.0`) made by `make release`; see [Versioning](README.md#versioning) for when to bump which part.

Add a line under **Unreleased** in the same commit as the change. Start it with **Breaking:** when it changes behavior agents rely on, or **New:** for a new rule or requirement; leave wording fixes unmarked. `make release` reads those marks to pick the version: any Breaking line makes a major release, else any New line a minor one, else a patch. It refuses to run while Unreleased is empty, then renames it to the new version and date.

## Unreleased

- **Breaking:** backlog priorities are p0 to p5; p5 is the icebox, skipped by work and groom and only counted by list.
- **New:** Design principle 13: prefer clear, familiar, monochrome icons over text; no emoji icons.
- **New:** Design principle 10: a control's whole visible boundary responds to every interaction (hover, click, tap, focus, cursor change) and nothing outside it does; focus rings and glows are drawn inside the box, and a frame around a native control forwards interactions to it.
- **New:** Frontend suggests the volta component library.
- Hover may resize an element if its hover/click mask stays the same.
- **New:** Native: `make install-open` closes the running app and reopens it; macOS app builds go in `build/`, not `.build/`.
- **New:** Native in prototyping mode: tests run locally after each commit and in CI; CI tests and builds apps only on release tags.
- **New:** Rebase merges are always preferred, including for pull requests and auto-merge, and merged branches are deleted on `origin` and locally.
- **New:** This repo keeps a changelog, and `make release` picks the version from it: major for Breaking entries, minor for New ones, patch otherwise.

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
