# Agent Instructions

## Project Overview

This is a personal resume/CV project built with [Awesome-CV](https://github.com/posquit0/Awesome-CV), a LaTeX template. The `awesome-cv.cls` class file is vendored from upstream (no local modifications).

## Project Structure

```
resume/
├── vendor/awesome-cv/   ← vendored awesome-cv.cls from upstream
├── resume.tex           ← main document (personal info, section imports)
├── resume/              ← section content files
│   ├── summary.tex
│   ├── experience.tex
│   ├── skills.tex
│   └── education.tex
├── Dockerfile           ← texlive image with required fonts
├── Makefile             ← build targets
└── .beads/              ← beads task tracking database
```

## Building the Resume

LaTeX compilation is done via Docker. Never install LaTeX locally.

```bash
make              # builds resume.pdf via Docker (builds image if needed)
make docker-build # rebuild Docker image only (after Dockerfile changes)
make clean        # remove build artifacts
```

## Editing Content

- **Personal info**: Edit the preamble of `resume.tex` (`\name`, `\email`, `\github`, etc.)
- **Section content**: Edit files in `resume/` — each file is one section
- **Add/remove sections**: Comment/uncomment `\input{resume/...}` lines in `resume.tex`
- **Accent color**: Change `\colorlet{awesome}{awesome-skyblue}` in `resume.tex`
- **Do NOT edit** `vendor/awesome-cv/awesome-cv.cls` — it should match upstream exactly

### LaTeX Commands Reference

| Command | Usage |
|---|---|
| `\cventry{title}{org}{loc}{date}{items}` | Work/education entry |
| `\cvskill{category}{skills}` | Skill row |
| `\begin{cvitems}...\end{cvitems}` | Bullet list in an entry |
| `\begin{cvparagraph}...\end{cvparagraph}` | Free-text block (summary) |
| `\cvsection{Title}` | Section heading |

## Updating Awesome-CV

```bash
curl -sL https://raw.githubusercontent.com/posquit0/Awesome-CV/master/awesome-cv.cls \
  -o vendor/awesome-cv/awesome-cv.cls
# Update the commit hash in vendor/awesome-cv/README.md
make docker-build && make   # verify build still works
```

<!-- BEGIN BEADS INTEGRATION -->
## Issue Tracking with bd (beads)

**IMPORTANT**: This project uses **bd (beads)** for ALL issue tracking. Do NOT use markdown TODOs, task lists, or other tracking methods.

Run `bd prime` for full workflow context.

### Quick Reference

```bash
bd ready              # Find unblocked work
bd show <id>          # View issue details
bd create "Title" --type task --priority 2  # Create issue
bd update <id> --claim                      # Claim work atomically
bd close <id> --reason "Done"               # Complete work
bd sync               # Sync with git (run at session end)
```

### Issue Types & Priorities

**Types:** `bug`, `feature`, `task`, `epic`, `chore`

**Priorities:** `0` critical → `1` high → `2` medium → `3` low → `4` backlog

### Agent Workflow

1. `bd ready` — find unblocked work
2. `bd update <id> --claim` — claim it
3. Do the work
4. `bd close <id> --reason "Done"` — complete it
5. Discovered new work? `bd create "Title" --deps discovered-from:<id>`

### Critical Agent Rules

- ❌ **Never use `bd edit`** — it opens an interactive editor and hangs. Use `bd update <id> --description "..."` instead.
- ✅ Use stdin for descriptions with special characters:
  ```bash
  echo 'Description with `backticks` and "quotes"' | bd create "Title" --description=-
  ```
- ✅ Always use `--json` flag for programmatic parsing
- ✅ Link discovered work with `discovered-from` dependencies
- ❌ Do NOT create markdown TODO lists or use external trackers
<!-- END BEADS INTEGRATION -->

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - `make` to verify the resume builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd sync
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds
