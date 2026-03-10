# Forking This Repo

This repository is structured so you can fork it and replace the personal content with your own while keeping all the build infrastructure, CI pipelines, and tooling.

## Quick Start

1. **Fork or use as template** on GitHub
2. **Copy the example files** to create your personal content:

```bash
# Resume personal info
cp cv/resume/personal.tex.example cv/resume/personal.tex

# Resume sections
cp cv/resume/summary.tex.example cv/resume/summary.tex
cp cv/resume/experience.tex.example cv/resume/experience.tex
cp cv/resume/skills.tex.example cv/resume/skills.tex
cp cv/resume/education.tex.example cv/resume/education.tex

# Landing page
cp site/hugo.toml.example site/hugo.toml
```

3. **Edit each file** with your own information
4. **Replace site assets** in `site/static/`:
   - `images/profile.jpg` — your profile photo
   - `CNAME` — your custom domain (or delete it)
   - Favicons — generate your own at [realfavicongenerator.net](https://realfavicongenerator.net)
5. **Build locally** to verify:

```bash
make -C cv docker-build   # one-time Docker image setup
make -C cv                # build resume PDF
```

## What's Personal vs. Base

### Personal files (replace these)

| File | Purpose |
|---|---|
| `cv/resume/personal.tex` | Name, contact info, social links |
| `cv/resume/summary.tex` | Professional summary |
| `cv/resume/experience.tex` | Work history |
| `cv/resume/skills.tex` | Skills list |
| `cv/resume/education.tex` | Education |
| `site/hugo.toml` | Site title, bio, links, analytics |
| `site/static/*` | Profile photo, favicons, CNAME |

### Base infrastructure (keep as-is)

| File/Dir | Purpose |
|---|---|
| `cv/resume.tex` | Document structure and LaTeX config |
| `cv/vendor/awesome-cv/` | Vendored Awesome-CV LaTeX class |
| `cv/Dockerfile` | TexLive build environment |
| `cv/Makefile` | Build targets |
| `.github/workflows/build.yml` | CI: compile PDF and publish release |
| `.github/workflows/deploy-site.yml` | CI: deploy Hugo site to GitHub Pages |

## CI Setup

After forking, enable these in your repo settings:

- **GitHub Pages**: Settings → Pages → Source: GitHub Actions
- **Releases**: The `build.yml` workflow auto-publishes `resume.pdf` to a `latest` release on every push to `master`

Update the resume download URL in `site/hugo.toml` to point to your fork's releases.
