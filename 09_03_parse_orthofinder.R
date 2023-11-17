### load packages
library(tidyverse)
library(data.table)
library(cowplot)
library(RColorBrewer)

library(UpSetR)


### Import datasets

wd <- "/Users/leabroennimann/Desktop/Master_Bioinformatik/3._Semester/organization_annotation_eukaryte_genomes/08_comparative_genomics"

# Comparative_Genomics_Statistics/Statistics_PerSpecies.tsv
stat_per_sp <- paste0(wd, "/Statistics_PerSpecies.tsv")
dat <- fread(stat_per_sp)
ids=names(dat)
dat <- gather(dat, species, perc, ids[ids!="V1"], factor_key = TRUE)

# Orthogroups/Orthogroups.GeneCount.tsv
gene_count <- paste0(wd, "/Orthogroups.GeneCount.tsv")
ogroups <- fread(gene_count)

# Define output dir for plots
plot_dir <- paste0(wd, "/orthofinder_plots")
dir.create(plot_dir)

### 1) Summarize Orthofinder statistics per species


## Parse Dataset 
o_ratio <- dat %>%
  filter( V1 %in% c("Number of genes", "Number of genes in orthogroups", "Number of unassigned genes",
                    "Number of orthogroups containing species", "Number of species-specific orthogroups", 
                    "Number of genes in species-specific orthogroups"
  ))

o_percent <- dat %>%
  filter( V1 %in% c(
    "Percentage of genes in orthogroups", "Percentage of unassigned genes", "Percentage of orthogroups containing species",
    "Percentage of genes in species-specific orthogroups"
  ))


## Plot

p <- ggplot(o_ratio, aes(x =  V1, y = perc, fill = species)) +
  geom_col(position = "dodge") +
  scale_fill_brewer(palette = "Paired") +
  theme_cowplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(y = "Count")
ggsave(paste0(plot_dir, "/orthogroup_number_plot.pdf"))

p <- ggplot(o_percent, aes(x =  V1, y = perc, fill = species)) +
  geom_col(position = "dodge") +
  ylim(c(0, 100)) +
  scale_fill_brewer(palette = "Paired") +
  theme_cowplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(y = "Count")
ggsave(paste0(plot_dir, "/orthogroup_percentage_plot.pdf"))



### 2) PLot co-occurrence of Orthogroups

## parse dataset
ogroups <- ogroups %>% select(-Total)
ogroups_presence_absence <- ogroups
rownames(ogroups_presence_absence) <- ogroups_presence_absence$Orthogroup
ogroups_presence_absence[ogroups_presence_absence > 0] <- 1
ogroups_presence_absence$Orthogroup <- rownames(ogroups_presence_absence)

str(ogroups_presence_absence)
ogroups_presence_absence$Orthogroup

ogroups_presence_absence <- ogroups_presence_absence %>%
  rowwise() %>%
  mutate(SUM = sum(c_across(ends_with("proteins"))))


genomes <- names(ogroups_presence_absence)[grepl("proteins",names(ogroups_presence_absence))]
ogroups_presence_absence <- data.frame(ogroups_presence_absence)
ogroups_presence_absence[genomes] <- ogroups_presence_absence[genomes] == 1


## plot data using the ComplexUpset package
library(ComplexUpset)

pdf(paste0(plot_dir, "/one-to-one_orthogroups_plot.pdf", height = 5, width = 10, useDingbats = FALSE))
upset(ogroups_presence_absence, genomes, name = "genre", width_ratio = 0.1, wrap = TRUE, set_sizes = FALSE)
dev.off()

