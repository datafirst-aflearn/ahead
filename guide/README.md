# AHEAD User Guide (bookdown)

A self-contained [bookdown](https://bookdown.org/) project, modeled on the PASEC/AMPL guides, that builds into `docs/guide/`. It is completely separate from the Quarto catalogue build (`render_site.R` → `docs/index.html`, `docs/catalogue.html`, `docs/studies/`), so rendering the guide never touches the catalogue and vice versa.

## Adding a new chapter

1. Create a new file `guide/0N-some-topic.Rmd` (next number in sequence) with a top-level heading, e.g.:

   ```markdown
   # Some Topic {#ch0N-some-topic}

   Chapter content goes here.
   ```

2. Add it to the `rmd_files` list in [`guide/_bookdown.yml`](_bookdown.yml), in the order it should appear in the table of contents:

   ```yaml
   rmd_files:
     - index.Rmd
     - 01-intro.Rmd
     - 0N-some-topic.Rmd
   ```

3. Re-render (see below). The new chapter shows up in the sidebar automatically and is published at `docs/guide/0N-some-topic.html`.

## Rendering

From the repo root in R/RStudio:

```r
source("guide/render_guide.R")
```

Or from inside `guide/`:

```r
source("render_guide.R")
```

Both are equivalent to running `bookdown::render_book("index.Rmd")` from `guide/`, but also clear stale caches and write only into `../docs/guide/`.

This is **not** run automatically by `render_site.R`. The catalogue and the guide are rendered independently — re-render whichever one you changed.

## Structure

- `_bookdown.yml` — book config: output filename, `output_dir: ../docs/guide`, and the ordered `rmd_files` list
- `_output.yml` — `bookdown::gitbook` output settings (CSS, TOC logo, home link)
- `index.Rmd` — book title page / welcome chapter (`# Welcome {-}`)
- `01-intro.Rmd`, `0N-*.Rmd` — numbered chapters, one file per chapter
- `style.css` — AFLEARN-aligned styling (off-white `#EEF3F7` base, navy `#0D0D52` chrome, blue `#0049FF` accents)
- `home-link.html` — small "Back to AHEAD" link injected above each chapter, pointing at `../index.html` (the main AHEAD landing page)
- `files/` — images used by the guide (e.g. the TOC logo); copied into `docs/guide/files/` on render

## Linking chapters from the AHEAD landing page

Once there are chapters worth featuring, link to them directly from `aflearn_study_pages.R`'s landing page cards using paths like `guide/01-intro.html` (relative to `docs/`). This has not been done yet — it's a deliberate follow-up once the guide has real content.
