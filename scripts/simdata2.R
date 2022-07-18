library("tidyverse")

set.seed(62)

covmx <- matrix(c(30^2, .9 * 30 * 33,
                  .9 * 30 * 33, 33^2), ncol = 2)

rmx <- MASS::mvrnorm(18, mu = c(S0i = 0, S1i = 0),
                     Sigma = covmx)

rmx_tbl <- rmx %>%
  as_tibble() %>%
  mutate(Subject = factor(1:18)) # need this to join with obs

obs <- tibble(Subject = factor(rep(seq_len(18), each = 10)),
              Days = rep(0:9, 18),
              gamma_00 = 310,  # replace with correct values
              gamma_10 = 4,  # replace with correct values
              e_ij = rnorm(18 * 10, 0, 25))      # replace with correct values

simdata2 <- inner_join(obs, rmx_tbl, "Subject") %>%
  mutate(Reaction = gamma_00 + S0i + (gamma_10 + S1i) * Days + e_ij) %>%
  select(Subject, Days, Reaction)

saveRDS(simdata2, "data/simdata2.rds")
