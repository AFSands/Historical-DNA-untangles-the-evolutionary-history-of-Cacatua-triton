#################################################
# NOTES: This script was run in RStudio. See the associated study for information on the R version and further details. This script uses the outputs of Step12.2 to merge individual tree files into a single trees file (i.e. merging bootstrap replicates), which can be used to determine support in Step12.5.2. Note that the output was manually trimmed of its header and the names of each run to be consistent with a newick *.trees file. The revised output was called "combined_m3.trees" before proceeding to Step12.5.2. 
#################################################


# -------------------------------
# Set directory
# -------------------------------
dir_path <- "C:/Users/Franc/Documents/Hong Kong University Work/Projects/Cockatoos/Paper2/Results/TreeMix/Revised/Regions/CMrooted/Results"

# -------------------------------
# List all *.3.treeout.gz files
# -------------------------------
files <- list.files(
  path = dir_path,
  pattern = "\\.3\\.treeout\\.gz$",
  full.names = TRUE
)

# -------------------------------
# Read first line from each gz file
# -------------------------------
get_first_line <- function(file) {
  con <- gzfile(file, open = "rt")
  line <- readLines(con, n = 1)
  close(con)
  line
}

trees <- vapply(files, get_first_line, character(1))

# -------------------------------
# Write trees only (one per line)
# -------------------------------
writeLines(
  text = trees,
  con = file.path(dir_path, "TreeMix_first_line_trees.txt")
)
