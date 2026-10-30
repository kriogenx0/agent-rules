## Documentation

Keep docs up to date with the architecture, including architectural diagrams, in the `docs/` folder. Keep the root directory small (see Root Directory in [code-requirements.md](code-requirements.md)).

- **Rules vs. project docs.** `docs/rules/` holds the shared rules, the same in every project. `docs/project/` holds only that project's settings (`settings.md`) and facts: stack, layout, commands, product terms, roles, deployment targets. Project docs never relax, replace or add rules; a needed change in behavior goes into the shared rules or becomes a setting.
- **Agent loaders.** The root `AGENTS.md` is a short loader that points at `docs/rules/`, `docs/project/` and the feature index; `CLAUDE.md` just imports `AGENTS.md`. Edit the rules and project docs, not `CLAUDE.md`.
- **Services.** Document every internal and external service the project uses, why it is used, and the configuration variables it needs.
- **Planned and shipped work.** Planned work lives in `docs/backlog/` (one file per task) and implemented work in `docs/features/`; see [backlog.md](backlog.md) and [feature-docs.md](feature-docs.md). Split larger initiatives into independently actionable task files rather than writing them into a shared file.
- **Code wins.** When a doc and the code disagree, the code is right. Fix the doc when you touch that area.
