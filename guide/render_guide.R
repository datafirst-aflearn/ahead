# Render the AHEAD User Guide bookdown project into docs/guide/.
# Run from RStudio: source("guide/render_guide.R")
# Or, from inside guide/: source("render_guide.R")
#
# This is completely independent of render_site.R (the Quarto catalogue build).
# It never touches docs/index.html, docs/catalogue.html, or docs/studies/.

# Allow running this from the repo root (source("guide/render_guide.R")) or
# from inside guide/ itself (source("render_guide.R")).
cwd <- normalizePath(getwd(), winslash = "/", mustWork = FALSE)
if (file.exists(file.path(cwd, "guide", "_bookdown.yml"))) {
  root <- file.path(cwd, "guide")
} else if (file.exists(file.path(cwd, "_bookdown.yml"))) {
  root <- cwd
} else {
  stop("Could not find guide/_bookdown.yml. Run this from the repo root or from guide/.")
}

setwd(root)

if (!requireNamespace("bookdown", quietly = TRUE)) {
  stop("Package 'bookdown' is required. Install with: install.packages(\"bookdown\")")
}

# Remove stale knitr/bookdown cache so edits are always reflected.
for (d in c("ahead-user-guide_cache", "_bookdown_files")) {
  if (dir.exists(d)) unlink(d, recursive = TRUE)
}

message("Rendering AHEAD User Guide to ../docs/guide/ ...")
bookdown::render_book("index.Rmd", quiet = FALSE)

guide_dir <- normalizePath(file.path(root, "..", "docs", "guide"), winslash = "/", mustWork = FALSE)

# Ensure guide assets (logos, PDFs, etc.) are published alongside the HTML.
files_src <- file.path(root, "files")
files_dst <- file.path(guide_dir, "files")
if (dir.exists(files_src) && dir.exists(guide_dir)) {
  dir.create(files_dst, recursive = TRUE, showWarnings = FALSE)
  file.copy(
    list.files(files_src, full.names = TRUE),
    files_dst,
    overwrite = TRUE,
    recursive = TRUE
  )
}

nojekyll <- file.path(guide_dir, ".nojekyll")
if (dir.exists(guide_dir) && !file.exists(nojekyll)) {
  writeLines("", nojekyll)
}

message(
  "\nDone. Published: ", guide_dir, "/index.html\n",
  "\nThis build only touches docs/guide/ — the catalogue (docs/index.html, ",
  "docs/catalogue.html, docs/studies/) is untouched.\n",
  "Next: git add docs/guide/ guide/ && git commit && git push"
)
