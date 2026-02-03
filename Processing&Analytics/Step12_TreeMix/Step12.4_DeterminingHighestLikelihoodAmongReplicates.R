#################################################
# NOTES: This script was run in RStudio. See the associated study for information on the R version and further details. This script was used to determine the replicate with the highest likelihood among the 100 bootstrap replicates under migration edges (m) = 3. The best replicates under different m values were determined by adjusting point 2 by changing "3" to other values (e.g. 1, 2, ... etc).  
#################################################


## -----------------------------
## 1. Set working directory
## -----------------------------
setwd("C:/Users/Franc/Documents/Hong Kong University Work/Projects/Cockatoos/Paper2/Results/TreeMix/Revised/Regions/CMrooted/Results")

## -----------------------------
## 2. List all *.3.llik files
## -----------------------------
files <- list.files(pattern = "\\.3\\.llik$")

## -----------------------------
## 3. Function to extract final likelihood
## -----------------------------
extract_likelihood <- function(file) {
  lines <- readLines(file)
  
  # Find the line that starts with "Exiting ln(likelihood)"
  target_line <- grep("^Exiting ln\\(likelihood\\)", lines, value = TRUE)
  
  # Extract the numeric value after the colon
  value <- sub(".*:\\s*", "", target_line)
  
  data.frame(
    file = file,
    final_ln_likelihood = as.numeric(value),
    stringsAsFactors = FALSE
  )
}

## -----------------------------
## 4. Apply function to all files
## -----------------------------
results <- do.call(rbind, lapply(files, extract_likelihood))

## -----------------------------
## 5. Write tab-delimited output
## -----------------------------
write.table(
  results,
  file = "TreeMix_final_likelihoods.txt",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)

## -----------------------------
## 6. View results
## -----------------------------
print(results)
