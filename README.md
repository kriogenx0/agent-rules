# Agent Rules

The purpose of this repo is to keep all shared agent rules in one place. This repo should never contain information about a specific codebase or repo.

Author: Alex Vaos

## How rules are split

- **Shared rules** live here in [docs/rules/](docs/rules/). They are project-agnostic: no stack, library, host or command specifics.
- **Project settings and facts** live in each repo's own `docs/project/`: `settings.md` (platforms, prototyping mode) and facts such as the stack, repo layout, commands, product terms and deployment targets. They never change a rule. If a project needs different behavior, change the shared rule here or add a setting.

Each repo copies `docs/rules/` from here and keeps its own `docs/project/`. Its root `AGENTS.md` loads both, and `CLAUDE.md` just imports `AGENTS.md`.

Every repo also keeps `docs/project/settings.md` (start from [templates/settings.md](templates/settings.md)), which records:

- **Platforms:** which of frontend, backend, mac, iOS the repo is for. Only rules for those platforms apply.
- **Prototyping mode:** `on` means ordinary changes go directly to main; backlog tasks use branches, and completed ones merge to main automatically.

## Rules

- [project-settings.md](docs/rules/project-settings.md): the per-repo settings file (platforms, prototyping mode). Read first.
- [conventions.md](docs/rules/conventions.md): general code, test, and git conventions.
- [code-requirements.md](docs/rules/code-requirements.md): coding standards (DRY, data files, linting, folder structure, web app architecture).
- [frontend.md](docs/rules/frontend.md): styles (SCSS), class names, the volta component library, UI components, views, API clients, accessibility.
- [backend.md](docs/rules/backend.md): health checks, databases, initializers, routes, API.
- [native.md](docs/rules/native.md): macOS and iOS apps, including their make targets and running CI only on release tags in prototyping mode.
- [design-principles.md](docs/rules/design-principles.md): UI and interaction principles every page must meet.
- [documentation.md](docs/rules/documentation.md): where docs live and what they must cover.
- [backlog.md](docs/rules/backlog.md): how backlog tasks (`docs/backlog/`) are written, picked up, and completed.
- [backlog-mode.md](docs/rules/backlog-mode.md): the autonomous branch-per-task mode used when told to "work on the backlog".
- [prototyping-mode.md](docs/rules/prototyping-mode.md): when the user says it's on, push ordinary changes to main and automatically merge completed backlog branches; keep incomplete tasks on branches.
- [feature-docs.md](docs/rules/feature-docs.md): what goes in a `docs/features/` doc.
- [deployment.md](docs/rules/deployment.md): hands off production and the general deployment standard.
- [make-files.md](docs/rules/make-files.md): standard make targets.
- [versioning.md](docs/rules/versioning.md): semver in a project's `VERSION` file, bumped only by `make release`.

## Versioning

The rules use semantic versioning: each release is a git tag (`v1.4.0`), and [CHANGELOG.md](CHANGELOG.md) says what changed in it. There is no `VERSION` file. Each synced file's header records the version and commit it came from (`agent-rules@1.4.0 (abc1234)`, or `1.4.0+2` when synced from two commits past the tag), and installing into a repo shows it. `make version` prints the current one. A repo can see which release it has from those headers, and what changed since from the changelog.

Which part to bump:

- **Major** (`2.0.0`): a rule changes or drops behavior that agents or repos already rely on, so following the new rules means doing something differently (a renamed make target, a different branch flow, changed priority levels).
- **Minor** (`1.5.0`): a new rule, or a new requirement added to an existing one, that doesn't break what agents already do.
- **Patch** (`1.4.1`): wording, clarifications and fixes that don't change what agents do.

When in doubt between two, pick the larger. The author can always make the call.

Every commit that changes these shared rules adds a line under **Unreleased** in CHANGELOG.md in the same commit, starting it with **Breaking:** for a major change or **New:** for a minor one (wording fixes stay unmarked), and must receive a version bump: after committing, run `make release` before considering the change finished. This requirement is specific to this repository.

`make release` is the only way to make a version, and it picks the bump automatically from those marks: any Breaking entry makes a major release, else any New entry a minor one, else a patch. `BUMP=patch|minor|major` overrides it. It runs the tests, renames the Unreleased section to the new version and date, commits that as `Release vX.Y.Z`, tags the commit with the release notes, and pushes the commit and the tag. It refuses uncommitted changes, an empty Unreleased section, and a commit that is already released. Then run `make sync-all` to send the release to every repo.

## Sources

Pulled from `docs/rules/` in inertia, pocketproducer-web, ironyoung-web and paulandvaos (2026-10-30). pocketproducer-web's already-generalized rules are the base.
