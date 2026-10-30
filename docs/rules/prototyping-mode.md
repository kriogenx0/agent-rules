## Prototyping Mode

Applies only when the repo's `docs/project/settings.md` sets `Prototyping mode: on`, or the user says it's on for the session (see [project-settings.md](project-settings.md)). It is off by default. When on, it overrides the branch, pull request, and push rules in [conventions.md](conventions.md) and [backlog-mode.md](backlog-mode.md); everything else still holds.

- **No branches or PRs.** Work directly on the main branch. Don't create branches, worktrees, or pull requests.
- **Commit and push everything to main.** Commit each coherent change with a `git log`-style message and push it to main without asking. `git fetch` and rebase onto `origin/main` first so you never overwrite newer work.
- **Keep the checks.** Still run the tests and lint you can, and say plainly which you couldn't run. Never push a change you know breaks the build or the tests.
- **Deploys.** If pushing main triggers a production deploy (see the project's deployment doc), prototyping mode authorizes that push; the "hands off production" limits in [deployment.md](deployment.md) still apply to everything else.
- **Backlog tasks.** If working through the backlog while prototyping mode is on, complete each task on main (code, tests, feature docs, task file removed) instead of using a branch per task.
- **Turning it off.** When the user says prototyping mode is off, or the settings file says `off`, return to the normal branch and PR workflow.
