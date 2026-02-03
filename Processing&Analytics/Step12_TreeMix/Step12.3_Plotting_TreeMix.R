#################################################
# NOTES: This script was run in RStudio. See the associated study for information on R version and further details. This script was used to plot all replicate outputs from Step12.2 for the migration edges (m) 1-3 and save these as PDFs. 
#################################################


# Set working directory
setwd("C:/Users/Franc/Documents/Hong Kong University Work/Projects/Cockatoos/Paper2/Results/TreeMix/Revised/Regions/CMrooted/Results")

# Parameters
prefix <- "TreeMix."
replicate_range <- 1:100   # Run all replicates from 1 to 100
edge_range <- 1:3            # Can also be 1:3, etc.
plots_per_pdf <- 6         # Number of plots per PDF

# Load required libraries
library(RColorBrewer)
library(R.utils)

# Source TreeMix plotting functions
source("C:/Users/Franc/Documents/Hong Kong University Work/Projects/Cockatoos/Paper2/Results/TreeMix/treemix/plotting_funcs.R")

# Loop through each edge value
for (edge in edge_range) {
  
  # Break replicate range into chunks of 6
  replicate_groups <- split(replicate_range, ceiling(seq_along(replicate_range) / plots_per_pdf))
  
  # Loop through each group of replicates
  for (group in replicate_groups) {
    
    # Dynamically generate PDF filename with replicate range and edge number
    pdf_filename <- paste0(prefix, min(group), "-", max(group), "_edge", edge, ".pdf")
    
    # Open A4 landscape PDF device
    pdf(file = pdf_filename, width = 11.7, height = 8.3)  # A4 size in inches (landscape)
    
    # Set layout for plots
    par(mfrow = c(2, 3))  # 2 rows x 3 columns = 6 plots per page
    
    # Plot each replicate in the group
    for (replicate in group) {
      plot_tree(cex = 0.5, paste0(prefix, replicate, ".", edge))
      title(paste(edge, "edges - replicate", replicate))
    }
    
    # Close PDF device to save the file
    dev.off()
    
    cat("PDF saved as:", pdf_filename, "\n")
  }
}
