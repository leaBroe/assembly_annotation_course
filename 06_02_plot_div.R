## laod packages
library(dplyr)
library(data.table)
library(tidyr)
library(reshape2)
library(ggplot2)
library(cowplot)

## set working directory
# setwd("/media/Data/manuel/EDTA/TE_dating")

## Import the modified output from parseRM.pl ending with "landscape.Div.Rname.tab
dat <- fread("/Users/leabroennimann/Desktop/Master_Bioinformatik/3._Semester/organization_annotation_eukaryte_genomes/polished.fasta.mod.out.landscape.Div.Rname.tab")

colnames(dat) <- c("Rname", "Rclass", "Rfam", 1:50)
dat <- dat %>%
    separate(Rname, into = c("TE", "Num"), sep = "_") %>%
    mutate(TE_fam = paste0(TE, Num))

## Reshape table
rep_table <- dat
rep_table.m <- melt(rep_table)
rep_table.m <- rep_table.m[-c(which(rep_table.m$variable == 1), which(rep_table.m$variable %in% c(41:51))), ] # remove the peak at 1 and at 40

## Estimate age of insertion
## calibrated synonymous substitution rate # https://academic.oup.com/plcell/article/26/7/2777/6100188
rep_table.m$age <- (as.numeric(rep_table.m$variable) / ((8.22 * 10^-9) * 100)) / 1000000 


## Change name of superfamilies
rep_table.m <- rep_table.m %>%
    mutate(Superfamily = case_when(
        Rfam == "Copia" ~ "LTR/Copia",
        Rfam == "Gypsy" ~ "LTR/Gypsy",
        Rfam == "unknown" ~ "LTR/Unknown",
        Rfam == "LINE" ~ "LINE",
        Rfam == "Helitron" ~ "DNA/Helitron",
        Rfam == "DTM" ~ "DNA/DTM",
        Rfam == "DTT" ~ "DNA/DTT",
        Rfam == "DTH" ~ "DNA/DTH",
        Rfam == "DTC" ~ "DNA/DTC",
        Rfam == "DTA" ~ "DNA/DTA",
    ))

rep_table.m$Superfamily <- factor(rep_table.m$Superfamily, levels = c(
    "LTR/Gypsy", "LTR/Copia", "LTR/Unknown", "DNA/Helitron",
    "DNA/DTM", "DNA/DTC", "DNA/DTH", "DNA/DTA",
    "DNA/DTT", "LINE"
))


## calculate stats for each superfamily
rep_uncounted <- tidyr::uncount(rep_table.m, value)
rep_table_stat <- setDT(rep_uncounted)[, list(Mean = mean(age), Max = max(age), Min = min(age), Median = as.numeric(median(age)), Std = sd(age)), by = Superfamily]


## Plot

p1 <- ggplot(rep_table.m, aes(fill = Superfamily, x = age, weight = value / 1000000)) +
    geom_bar() +
    cowplot::theme_cowplot() +
    geom_vline(
        xintercept = 11.48, color = "red",
        linetype = "dashed", size = 1
    ) +
    geom_vline(
        xintercept = 32.42, color = "blue",
        linetype = "dashed", size = 1
    ) +
    scale_fill_brewer(palette = "Paired") +
    xlab("TE age (Myr)") +
    ylab("Sequence (Mbp)") +
    scale_x_continuous(limits = c(0, 50)) +
    theme(axis.text.x = element_text(angle = 90, vjust = 1, size = 9, hjust = 1), plot.title = element_text(hjust = 0.5))

ggsave(filename = "TE-myr.pdf", width = 10, height = 5, useDingbats = F)
