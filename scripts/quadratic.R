library("tidyverse")

pmx <- poly(1:20, 2, simple = TRUE)

qdata <- tibble(group = rep(c("A", "B"), each = 20),
                time = rep(1:20, times = 2),
                response = c(303 + pmx[, 1] * 12 +
                             pmx[, 2] * 18,
                             303 + pmx[, 1] * -14 +
                             pmx[, 2] * 1) +
                  rnorm(40, sd = 2))

saveRDS(qdata, file="data/quadratic.rds")

