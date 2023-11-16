library(ggplot2)
library(GENESPACE)
gpar <- init_genespace(wd = "analysis/genespace", path2mcscanx = "scripts/misc/MCScanX")
out <- run_genespace(gsParam = gpar, overwrite = T)


