# Changelog

What changed in each release of the shared rules, newest first. Versions are git tags (`v1.2.0`) made by `make release`; see [Versioning](README.md#versioning) for when to bump which part.

Add a line under **Unreleased** in the same commit as the change. Start it with **Breaking:** when it changes behavior agents rely on, or **New:** for a new rule or requirement; leave wording fixes unmarked. `make release` reads those marks to pick the version: any Breaking line makes a major release, else any New line a minor one, else a patch. It refuses to run while Unreleased is empty, then renames it to the new version and date.

## Unreleased

- Marketing sites: broken links are checked in `make test`, and the canonical host, `robots.txt` and sitemap are checked against production after each deploy.
- **New:** `marketing-site` platform and marketing-sites.md: creative design exempt from the design principles, server-side rendering, a focus on the app's value and top features, app screenshots and video or large free imagery, SEO, GEO (`llms.txt`, quotable facts, AI crawlers allowed), a generated sitemap, favicons, Open Graph, performance, calls to action, analytics and privacy, and forms.

## v2.0.0 (2026-11-20)

- **Breaking:** Design principle 14 is removed (principle 9 covers it). Principle 6 now has a hard cap of 300ms (was 500ms). Principles 1, 3, 5, 7, 8, 10, 11 and 12 now state exact sizes and tests (44px taps, 1920px displays, 12px edge margin), and drag is exempt from the box rule in principle 10.
- **New:** When agent-rules is added to a repo, immediately audit the repo against the rules for its platforms and fix every violation (project-settings.md).
- **New:** Design principle 13: the UI's own icons are never emojis; content people write or choose (text, messages, an emoji or image someone picks for their project) can use them.

## v1.5.0 (2026-11-20)

- **Breaking:** backlog priorities are p0 to p5; p5 is the icebox, skipped by work and groom and only counted by list.
- **New:** Design principle 9 now covers a minimal UI that never distracts from the task: every element earns its place, controls stay clear and familiar, wording and color stay simple, being minimal and organized comes first, and reducing interactions second.
- **New:** Design principle 13: prefer clear, familiar, monochrome icons over text; no emoji icons.
- **New:** Design principle 10: a control's whole visible boundary responds to every interaction (hover, click, tap, focus, cursor change) and nothing outside it does; focus rings and glows are drawn inside the box, and a frame around a native control forwards interactions to it.
- **New:** Frontend suggests the volta component library.
- Hover may resize an element if its hover/click mask stays the same.
- **New:** Native: `make install-open` closes the running app and reopens it; macOS app builds go in `build/`, not `.build/`.
- **New:** Native in prototyping mode: tests run locally after each commit and in CI; CI runs only on release tags and only tests; native apps (macOS, iOS, tvOS) aren't built in CI.
- **New:** Rebase merges are always preferred, including for pull requests and auto-merge, and merged branches are deleted on `origin` and locally.
- **New:** This repo keeps a changelog, and `make release` picks the version from it: major for Breaking entries, minor for New ones, patch otherwise.
- **New:** `audio-plugin` platform and audio-plugins.md: knobs (not sliders) for continuous parameters with exact value entry, controls through the plugin's parameter system, and realtime audio thread rules.

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
