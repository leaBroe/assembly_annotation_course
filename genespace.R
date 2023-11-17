library(ggplot2)
library(GENESPACE)
# clone MCScanX from https://github.com/wyp1125/MCScanX.git
gpar <- init_genespace(wd = "/data/users/lbroennimann/assembly_annotation_course/8_comparative_genomics", path2mcscanx = "/data/users/lbroennimann/assembly_annotation_course/MCScanX")
out <- run_genespace(gsParam = gpar, overwrite = T)


