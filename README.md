# AHEAD Catalogue

Interactive study-round browser and detail pages, built with **Quarto + reactable**.  
Published output for GitHub Pages lives in **`docs/`**.

## Quick start (RStudio)

1. Open **`aflearn-site.Rproj`** in RStudio.
2. Place these data files in the project root (same folder as the `.qmd` files):
   - **`EGRA_Harmonization_Waves_Details.xlsx`**
   - **`variable-availability-matrix.xlsx`** (`va-matrix` + `sub-tasks-desc` sheets; sub-task filter and study pages)
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
| `docs/index.html` | Browse page (study rounds table) |
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

If you update only the harmonisation Excel and need to refresh sub-task availability:

```bash
python build_variable_availability_matrix.py
```

Then re-render and push `docs/` as usual.

Then:

```bash
git add docs/
git commit -m "Update study rounds site"
git push
```

## Project layout

```
aflearn-site/
├── aflearn_dataset_reference_5.qmd   # Main Quarto source
├── aflearn_study_pages.R             # Study detail page generator
├── render_site.R                     # One-command render → docs/
├── _quarto.yml                       # Output directory: docs/
├── EGRA_Harmonization_Waves_Details.xlsx
├── variable-availability-matrix.xlsx   # Sub-task availability (va-matrix + sub-tasks-desc)
├── build_variable_availability_matrix.py  # Regenerate xlsx from harmonisation Excel
├── docs/                             # ← GitHub Pages publish root (committed)
│   ├── index.html
│   ├── studies/
│   └── .nojekyll
└── aflearn_variable_availability.qmd # Separate tool (not in main site yet)
```

## Variable availability browser

See `aflearn_variable_availability.qmd` for the harmonized variable coverage table.  
It can be linked or embedded from the main site in a later phase.

## Related links

- [DataFirst Data Portal](https://www.datafirst.uct.ac.za/dataportal/index.php) — harmonised dataset
- [Early Grade Reading Barometer](https://earlygradereadingbarometer.org/results) — UX reference
