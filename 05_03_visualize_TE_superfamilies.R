# load packages
#if (!require("BiocManager", quietly = TRUE))
  #install.packages("BiocManager")

#BiocManager::install("rtracklayer")

library(rtracklayer)

# Load the RColorBrewer package for better color palettes
#if (!require("RColorBrewer", quietly = TRUE))
  #install.packages("RColorBrewer")
library(RColorBrewer)

round_millions <- function(num){
  return(ceiling(num/1e+06)*1e+06)
}

# Load merged assembly GFF and convert it to a data frame
gff_path <- '/Users/leabroennimann/Desktop/Master_Bioinformatik/3._Semester/organization_annotation_eukaryte_genomes/polished.fasta.mod.EDTA.TEanno.gff3'
# Load GFF and convert it to a data frame
gff <- rtracklayer::import(gff_path)
gff_df <- as.data.frame(gff)

# Count the number of entries (features) for each scaffold
# scaffold_counts <- table(seqnames(gff))
scaffold_counts <- table(gff_df$seqnames)

# Find the scaffold with the most entries
largest_scaff <- names(which.max(scaffold_counts))

# Print the result
print(paste("The scaffold with the most entries is:", largest_scaff, "with", scaffold_counts[largest_scaff], "entries."))

# Filter gff df for this scaffold
largest_scaff_gff <- subset(gff_df, gff_df$seqnames == largest_scaff)

# Get bins
max_bp <- max(largest_scaff_gff$start)
max_bp_round <- round_millions(max_bp)
max_bin <- max_bp_round/1e+06
bin_ends <- seq(1, max_bin)
bin_strings <- string_sequence <- paste0(bin_ends - 1, "-", bin_ends, "Mbp")

# Get different clades (superfamilies etc.)
clades <- unique(largest_scaff_gff$Classification)
num_clades <- length(clades)

clades_bins <- matrix(data = NA, nrow = num_clades, ncol = max_bin, dimnames = list('clades'=clades, 'bins'=bin_strings))

# Fill in bins
for(clade in clades){
  for(bin_num in 1:max_bin){
    bin_start <- (bin_num-1)*1e+06
    bin_end <- (bin_num)*1e+06
    clades_bins[clade, bin_num] <- sum(largest_scaff_gff$Classification==clade & largest_scaff_gff$start >= bin_start & largest_scaff_gff$start < bin_end)
  }
}

pdf(paste0('TEs_by_Clades_and_Range_-_', largest_scaff, '.pdf'), width = max_bin + 2, height = 6)

par(mar = c(7, 4.5, 5, 2.5))


# Choose a color palette. If there are more clades than colors in the palette, 
# the palette colors will be repeated.
colors_clades <- brewer.pal(min(8, num_clades), "Set3")
if(num_clades > 8) {
  colors_clades <- colorRampPalette(colors_clades)(num_clades)
}

barplot(clades_bins, beside = F, col = colors_clades, border = "white", 
        xlab = "Range (start position)", ylab = "Frequency", 
        main = paste0("TEs by Clades and Range - ", largest_scaff),
        cex.names=0.8, las=1) 
legend('topright', legend=clades, fill=colors_clades, cex=0.8, bty="n", inset=c(0.1, 0.05))

# For the second plot, choose another color palette
colors_bins <- brewer.pal(min(8, max_bin), "Paired")
if(max_bin > 8) {
  colors_bins <- colorRampPalette(colors_bins)(max_bin)
}

barplot(t(clades_bins), beside = T, col = colors_bins, border = "white", ylab = "Frequency", 
        main = paste0("TEs by Clades and Range - ", largest_scaff),
        cex.names=0.8, las=2) 

mtext("Clade", side = 1, line = 5)  # Adjust the 'line' value as needed

legend('topright', legend=bin_strings, fill=colors_bins, cex=0.8, bty="n", inset=c(0.1, 0.05))

dev.off()

# Plot for ONE clade
# clade <- clades[1]
# clade_gff <- subset(largest_scaff_gff, largest_scaff_gff$Classification == clade)
# clade_gff <- clade_gff[order(clade_gff$start),]
# num_clade_TEs <- nrow(clade_gff)
# max_bp <- max(clade_gff$end)
# max_bp_round <- round_millions(max_bp)
# 
# plot(NA,NA, xlim=c(0, max_bp_round), ylim=c(0, num_clade_TEs))
# for (i in 1:nrow(clade_gff)) {
#   segments(clade_gff$start[i], i, clade_gff$end[i], i)
# }