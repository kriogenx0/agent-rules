# Agent Rules

The purpose of this repo is to keep all shared agent rules in one place. This repo should never contain information about a specific codebase or repo.

## How rules are split

- **Shared rules** live here in [docs/rules/](docs/rules/). They are project-agnostic: no stack, library, host or command specifics.
- **Project settings and facts** live in each repo's own `docs/project/`: `settings.md` (platforms, prototyping mode) and facts such as the stack, repo layout, commands, product terms and deployment targets. They never change a rule. If a project needs different behavior, change the shared rule here or add a setting.

Each repo copies `docs/rules/` from here and keeps its own `docs/project/`. Its root `AGENTS.md` loads both, and `CLAUDE.md` just imports `AGENTS.md`.

Every repo also keeps `docs/project/settings.md` (start from [templates/settings.md](templates/settings.md)), which records:

- **Platforms:** which of frontend, backend, mac, iOS the repo is for. Only rules for those platforms apply.
- **Prototyping mode:** `on` means no branches, no PRs, just work from main and push to main.

## Rules

- [project-settings.md](docs/rules/project-settings.md): the per-repo settings file (platforms, prototyping mode). Read first.
- [conventions.md](docs/rules/conventions.md): general code, test, and git conventions.
- [code-requirements.md](docs/rules/code-requirements.md): coding standards (DRY, data files, linting, folder structure, web app architecture).
- [frontend.md](docs/rules/frontend.md): styles (SCSS), class names, UI components, views, API clients, accessibility.
- [backend.md](docs/rules/backend.md): health checks, databases, initializers, routes, API.
- [native.md](docs/rules/native.md): macOS and iOS apps, including their make targets.
- [design-principles.md](docs/rules/design-principles.md): UI and interaction principles every page must meet.
- [documentation.md](docs/rules/documentation.md): where docs live and what they must cover.
- [backlog.md](docs/rules/backlog.md): how backlog tasks (`docs/backlog/`) are written, picked up, and completed.
- [backlog-mode.md](docs/rules/backlog-mode.md): the autonomous branch-per-task mode used when told to "work on the backlog".
- [prototyping-mode.md](docs/rules/prototyping-mode.md): when the user says it's on, no branches or PRs; commit and push everything to main.
- [feature-docs.md](docs/rules/feature-docs.md): what goes in a `docs/features/` doc.
- [deployment.md](docs/rules/deployment.md): hands off production and the general deployment standard.
- [make-files.md](docs/rules/make-files.md): standard make targets.
- [versioning.md](docs/rules/versioning.md): semver in `VERSION`, bumped only by `make release`.

## Sources

Pulled from `docs/rules/` in inertia, pocketproducer-web, ironyoung-web and paulandvaos (2026-10-30). pocketproducer-web's already-generalized rules are the base.
