# AGENTS.md

## Project type

This is a Nanoc static website using HAML templates and static assets under `content/`.

## Safety rules

- Do not modify `output/`, `tmp/`, `.DS_Store`, backup files, or generated files.
- Do not add files with names ending in ` 2.*`.
- Do not rename existing URLs unless explicitly asked.
- Preserve existing routes and legacy URL compatibility.
- Before editing, run `git status` and report whether the working tree is clean.
- Prefer small, reviewable changes.

## Build commands

- Build: `bundle exec nanoc`
- Check routes/build errors: `bundle exec nanoc`

## Content conventions

- HAML indentation is significant: use spaces consistently.
- Do not put inline content and nested content on the same HAML tag.
- Use `%hr` for horizontal rules.
- Keep existing page style and navigation structure.
- For new pages, follow nearby existing `.haml` files as templates.

## Completion criteria

- Run `bundle exec nanoc`.
- Show `git diff --stat`.
- Summarize changed files.
