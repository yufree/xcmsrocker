#!/usr/bin/env Rscript
# Unified R package installer for xcmsrocker.
#
# Usage: Rscript install_pkgs.R <cran|bioc|drat|github> <manifest.txt>
#
# Manifest format: one entry per line, `#` starts a comment.
#   - cran/bioc/drat: package name, e.g. `xcms`
#   - github:         `owner/repo[/subdir][@ref]`, e.g. `yufree/pmd`
#   - prefix an entry with `?` to mark it optional: a failure is reported
#     but does not fail the build.
#
# Unlike `R -e "install.packages(...)"`, which only warns when a package fails,
# every requested package is verified with requireNamespace() afterwards and
# the script exits non-zero if any non-optional package is missing.

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2L) {
  stop("usage: install_pkgs.R <cran|bioc|drat|github> <manifest>")
}
type <- match.arg(args[[1]], c("cran", "bioc", "drat", "github"))
manifest <- args[[2]]

DRAT_REPO <- "https://yufree.github.io/drat"

# ---- read manifest ----------------------------------------------------------
lines <- trimws(sub("#.*$", "", readLines(manifest, warn = FALSE)))
lines <- lines[nzchar(lines)]
optional <- startsWith(lines, "?")
entries <- trimws(sub("^\\?", "", lines))
names(optional) <- entries
if (!length(entries)) {
  message("Nothing to install in ", manifest)
  quit(status = 0)
}

# ---- environment ------------------------------------------------------------
ncpus <- max(1L, parallel::detectCores(), na.rm = TRUE)
options(Ncpus = ncpus, timeout = max(1200, getOption("timeout")))
Sys.setenv(MAKEFLAGS = paste0("-j", ncpus))

# GitHub token injected via `RUN --mount=type=secret,id=github_pat`;
# never written into an image layer.
pat_file <- "/run/secrets/github_pat"
if (file.exists(pat_file)) {
  pat <- trimws(readLines(pat_file, warn = FALSE)[1])
  if (!is.na(pat) && nzchar(pat)) Sys.setenv(GITHUB_PAT = pat)
}

ensure <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
}
ensure("BiocManager")
# CRAN (rocker's P3M snapshot) + matching Bioconductor release repos,
# so Bioc dependencies of CRAN/drat/GitHub packages resolve as well.
options(repos = BiocManager::repositories())

# ---- install ----------------------------------------------------------------
# `pkg_names` maps each manifest entry to the package name to verify.
pkg_names <- setNames(entries, entries)

switch(type,
  cran = {
    install.packages(entries)
  },
  bioc = {
    BiocManager::install(entries, update = FALSE, ask = FALSE)
  },
  drat = {
    install.packages(entries,
      repos = c(drat = DRAT_REPO, getOption("repos")),
      type = "source"
    )
  },
  github = {
    ensure("remotes")
    for (e in entries) {
      message("\n==> install_github('", e, "')")
      # fallback name: last path component without @ref
      guess <- basename(sub("@.*$", "", e))
      res <- tryCatch(
        remotes::install_github(e, upgrade = "never"),
        error = function(err) {
          message("ERROR installing ", e, ": ", conditionMessage(err))
          NULL
        }
      )
      pkg_names[[e]] <- if (length(res) && nzchar(res[[1]])) res[[1]] else guess
    }
  }
)

# ---- verify -----------------------------------------------------------------
ok <- vapply(pkg_names, function(p) {
  suppressWarnings(suppressMessages(requireNamespace(p, quietly = TRUE)))
}, logical(1))

failed <- names(ok)[!ok]
hard <- failed[!optional[failed]]
soft <- failed[optional[failed]]

message("\n===== ", type, " summary (", manifest, ") =====")
message("installed: ", sum(ok), "/", length(ok))
if (length(soft)) message("optional, FAILED (ignored): ", paste(soft, collapse = ", "))
if (length(hard)) {
  message("FAILED: ", paste(hard, collapse = ", "))
  quit(status = 1)
}

# ---- tidy up ----------------------------------------------------------------
unlink(list.files(tempdir(), full.names = TRUE), recursive = TRUE)
