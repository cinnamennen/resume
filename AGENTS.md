# Agent Instructions

## Project Overview

This is a personal resume/CV project built with [Awesome-CV](https://github.com/posquit0/Awesome-CV), a LaTeX template. The Awesome-CV repo is included as a git submodule and `awesome-cv.cls` is symlinked from it.

## Project Structure

```
resume/
├── Awesome-CV/          ← git submodule (do NOT edit files here)
├── awesome-cv.cls       ← symlink → Awesome-CV/awesome-cv.cls
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
- **Do NOT edit** anything inside the `Awesome-CV/` submodule directory

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
cd Awesome-CV && git pull origin master && cd ..
git add Awesome-CV
git commit -m "Update Awesome-CV submodule"
```

## Task Tracking (beads)

This project uses **bd** (beads) for issue tracking.

```bash
bd ready              # Find available work
bd show <id>          # View issue details
bd update <id> --status in_progress  # Claim work
bd close <id>         # Complete work
bd sync               # Sync with git
```

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
