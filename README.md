# AHEAD Catalogue

Interactive study-round browser and detail pages, built with **Quarto + reactable**.  
Published output for GitHub Pages lives in **`docs/`**.

## Quick start (RStudio)

1. Open **`aflearn-site.Rproj`** in RStudio.
2. Place these data files in the project root (same folder as the `.qmd` files):
   - **`ahead-catalogue-v1.xlsx`** — primary catalogue (home page, projects, surveys, subtasks, sampling, linking)
   - **`EGRA_Harmonization_Waves_Details.xlsx`** — still used for per-survey grade values (the catalogue stores grades at project level only)
3. Install R packages once:

```r
install.packages(c(
  "quarto", "readxl", "reactable", "htmltools", "dplyr", "stringr",
  "glue", "crosstalk", "tidyr", "htmlwidgets", "jsonlite"
))
```

4. Render the site:

```r
source("render_site.R")
```

This writes:

| Path | Purpose |
|------|---------|
| `docs/index.html` | Landing page (hero + "Access AHEAD dataset" / "Explore AHEAD catalogue" cards) |
| `docs/catalogue.html` | Browse page (study rounds table with filters) |
| `docs/studies/*.html` | One detail page per study round |
| `docs/.nojekyll` | Tells GitHub Pages not to run Jekyll |

Preview locally: open `docs/index.html` in a browser, or run a simple server:

```r
# R 4.1+
servr::httd(dir = "docs", port = 4321)
```

## GitHub Pages setup (one-time)

Repository: **[github.com/DataFirst-Courses/egra-egma](https://github.com/DataFirst-Courses/egra-egma)**

Live site URL (after Pages is enabled):  
**https://datafirst-courses.github.io/egra-egma/**

### 1. Link this R project to GitHub (RStudio)

Open **`aflearn-site.Rproj`**, then in the **Terminal** pane:

```bash
git remote add origin https://github.com/DataFirst-Courses/egra-egma.git
git branch -M main
git add .
git commit -m "Initial AFLearn EGRA/EGMA study rounds site"
git push -u origin main
```

If `git remote add` says the remote already exists:

```bash
git remote set-url origin https://github.com/DataFirst-Courses/egra-egma.git
```

**RStudio Git pane (alternative):** after the first `git commit`, use *Tools → Version Control → Project Options → Git/SVN* and set the remote URL to the repo above, then **Push** in the Git tab.

> **Important:** GitHub Pages will not offer a working `/docs` deploy until `docs/` exists on the `main` branch on GitHub. Push first, then configure Pages.

### 2. Enable GitHub Pages

On GitHub: **egra-egma → Settings → Pages**

| Setting | Value |
|---------|--------|
| Source | Deploy from a branch |
| Branch | `main` |
| Folder | `/docs` |

Click **Save**. Deployment can take 1–3 minutes.

If you do not see **/docs** in the folder dropdown, push your code first (step 1) and refresh the Settings page.

### 3. Organisation repos

If Pages settings are missing or greyed out, a **DataFirst-Courses org admin** may need to enable Pages under **Organisation Settings → Pages**.

### Update workflow (after Excel or content changes)

```r
source("render_site.R")
```

Then:

```bash
git add docs/
git commit -m "Update study rounds site"
git push
```

> **Note:** `variable-availability-matrix.xlsx` and `build_variable_availability_matrix.py` are no longer used by the site build. Subtask availability now comes from the `assessment-subtasks` and `subtask-descriptions` sheets in `ahead-catalogue-v1.xlsx`.

## Project layout

```
aflearn-site/
├── aflearn_dataset_reference_5.qmd   # Main Quarto source → docs/catalogue.html
├── aflearn_study_pages.R             # Landing page, study detail page & CSS generators
├── render_site.R                     # One-command render → docs/
├── _quarto.yml                       # Output directory: docs/
├── ahead-catalogue-v1.xlsx           # Primary catalogue (required)
├── EGRA_Harmonization_Waves_Details.xlsx  # Per-survey grades (optional but recommended)
├── docs/                             # ← GitHub Pages publish root (committed)
│   ├── index.html                    # Landing page (write_landing_page())
│   ├── catalogue.html                # Browse page (quarto_render output)
│   ├── studies/
│   └── .nojekyll
└── aflearn_variable_availability.qmd # Separate tool (not in main site yet)
```

The landing page (`docs/index.html`) is written directly by `write_landing_page()` in `aflearn_study_pages.R` during the same render pass — it is not a Quarto output file, the same way study detail pages aren't.

## Catalogue sheets used

| Sheet | Used for |
|-------|----------|
| `home-page` | Title, description, headline counts, filter vocabularies |
| `about-the-program` | Project name, acronym, description, study type/design, assessment |
| `assessment-surveys` | One row per survey round |
| `assessment-subtasks` | Which subtasks each survey administered |
| `subtask-descriptions` | Subtask titles and prose |
| `subtask-labels` | Assessment / core / alternate prefixes |
| `sampling-description` | Sampling prose on study detail pages |
| `link-to-source` | Harmonised ↔ source ID crosswalk |

## Related links

- [DataFirst Data Portal](https://www.datafirst.uct.ac.za/dataportal/index.php) — harmonised dataset
- [Early Grade Reading Barometer](https://earlygradereadingbarometer.org/results) — UX reference
