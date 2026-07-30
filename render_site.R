# Render the AFLearn study-rounds site into docs/ for GitHub Pages.
# Run from RStudio: source("render_site.R")
# Or: quarto::quarto_render("aflearn_dataset_reference_5.qmd") after Sys.setenv(AFLEARN_PUBLISH_DIR = "docs")

root <- if (sys.nframe() > 0 && !is.null(sys.frame(1)$ofile)) {
  dirname(normalizePath(sys.frame(1)$ofile, winslash = "/", mustWork = FALSE))
} else {
  normalizePath(getwd(), winslash = "/", mustWork = FALSE)
}
setwd(root)

if (!requireNamespace("quarto", quietly = TRUE)) {
  stop(
    "Package 'quarto' is required. Install with: install.packages(\"quarto\")\n",
    "Quarto CLI must also be installed (bundled with RStudio 2022+)."
  )
}

publish_dir <- "docs"
studies_dir <- file.path(publish_dir, "studies")
dir.create(studies_dir, recursive = TRUE, showWarnings = FALSE)

Sys.setenv(AFLEARN_PUBLISH_DIR = publish_dir)

message("Rendering site to ", publish_dir, "/ ...")
quarto::quarto_render("aflearn_dataset_reference_5.qmd", quiet = FALSE)

writeLines("", file.path(publish_dir, ".nojekyll"))

n_studies <- length(list.files(studies_dir, pattern = "\\.html$", recursive = TRUE))
message(
  "\nDone. Published files:\n",
  "  ", file.path(publish_dir, "index.html"), " (landing page)\n",
  "  ", file.path(publish_dir, "catalogue.html"), " (browse catalogue)\n",
  "  ", studies_dir, "/ (", n_studies, " study pages)\n",
  "\nNext: git add docs/ && git commit && git push\n",
  "GitHub repo Settings → Pages → Build from branch main, folder /docs"
)
