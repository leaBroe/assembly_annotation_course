library(ggplot2)
library(GENESPACE)
gpar <- init_genespace(wd = "/data/users/lbroennimann/assembly_annotation_course/09_genespace", path2mcscanx = "/data/users/lbroennimann/assembly_annotation_course/MCScanX")
out <- run_genespace(gsParam = gpar, overwrite = T)


