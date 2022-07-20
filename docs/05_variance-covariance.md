# Variance-covariance matrices

## Resources

[Slides](slides/05_vcov/index.html)

[Bivariate distributions app](https://dalejbarr.github.io/bivariate/index.html)

Note that the "code" pane of the app shows the code you would need to simulated data with the desired properties. This will be useful for the data simulation activity below.

[My book chapter on correlation](https://psyteachr.github.io/stat-models-v1/correlation-and-regression.html) goes over the topic in more depth, including a discussion of the relationship between correlation and regression.

## Activities

Play around with the app below until you are confident in interpreting variance-covariance matrices.

<iframe src="https://shiny.psy.gla.ac.uk/Dale/cvmx/?showcase=0" width="530px" height="480px" data-external="1"></iframe>

### Simulating data from covariance matrices

Below are some simulation exercises that call upon the function `mvrnorm()` from the `MASS` package. See the "code" pane of the first web app on this page for example code. You might want to step through it if you haven't encountered the `matrix()` function before. The `matrix()` function has a `byrow` option that allows you to enter the data row-by-row instead of column-by-column (the default), which makes life easier.

:::{.warning}
**WATCH OUT! Always use `MASS::mvrnorm()` without loading `library("MASS")`.**

The **`MASS`** package comes pre-installed with R. But the only function you'll probably ever want to use from **`MASS`** is `mvrnorm()`, so rather than load in the package using `library("MASS")`, it is preferable to use `MASS::mvrnorm()`, especially as **`MASS`** and the **`dplyr`** package from **`tidyverse`** don't play well together, due to both packages having the function `select()`. So if you load in **`MASS`** after you load in **`tidyverse`**, you'll end up getting the **`MASS`** version of `select()` instead of the **`dplyr`** version. It will do your head in trying to debug your code.
:::

#### A 2x2 matrix

:::{.try}
Simulate 12 observations for a 2x2 matrix for variables X and Y with the following parameter values:

- $\mu_X = -3.5$; $\mu_Y = 57$;
- $\sigma_X = 9$;
- $\sigma_Y = 11$;
- $\rho_{XY} = -.24$.


<div class='webex-solution'><button>solution</button>

```r
cov_xy <- -.24 * 9 * 11
mx1 <- matrix(c(9^2,    cov_xy,
                cov_xy, 11^2),
              nrow = 2, byrow=TRUE)

set.seed(62)
MASS::mvrnorm(12, mu = c(X = -3.5, Y = 57), mx1)
```

```
##                X        Y
##  [1,]  -9.814510 64.21756
##  [2,]   6.855451 65.42452
##  [3,]  11.215571 44.67337
##  [4,]  -3.521887 57.93585
##  [5,] -22.805532 76.67087
##  [6,]  -8.682815 55.37389
##  [7,] -16.711472 62.43408
##  [8,]   3.123118 44.84744
##  [9,]   6.588177 62.92306
## [10,]  -6.436933 43.12737
## [11,]  -5.181376 44.23210
## [12,] -18.449782 63.56265
```


</div>

:::

#### A 4x4 matrix

A 4x4 covariance matrix with variables W, X, Y, Z has the following structure.

$$
\begin{pmatrix}
{\sigma_w}^2              & \rho_{wx} \sigma_w\sigma_x & \rho_{wy}\sigma_w\sigma_y & \rho_{wz}\sigma_w\sigma_z \\
\rho_{xw}\sigma_x\sigma_w & {\sigma_x}^2 & \rho_{xy}\sigma_x\sigma_y & \rho_{xz}\sigma_x\sigma_z \\
\rho_{yw}\sigma_y\sigma_w & \rho_{yx}\sigma_y\sigma_x & {\sigma_y}^2 & \rho_{yz}\sigma_y\sigma_z \\
\rho_{zw}\sigma_z\sigma_w & \rho_{zx}\sigma_z\sigma_x & \rho_{zy}\sigma_z\sigma_y & {\sigma_z}^2 \\
\end{pmatrix}
$$

:::{.try}

Simulate 10 observations for a 4x4 matrix for variables W, X, Y, and Z with the following parameter values:

- $\mu_W = 5$; $\mu_X = -7$; $\mu_Y = 40$; $\mu_Z = -99$
- $\sigma_W = 2.64$;
- $\sigma_X = 1.93$;
- $\sigma_Y = 2.10$;
- $\sigma_Z = 2.92$;
- $\rho_{WX} = .39$;
- $\rho_{WY} = -.45$;
- $\rho_{WZ} = -.08$;
- $\rho_{XY} = -.03$;
- $\rho_{XZ} = .17$;
- $\rho_{YZ} = -.23$;


<div class='webex-solution'><button>hint</button>

```r
## It might be easiest to create variables representing the variances
## and covariances first and then reference them when building the matrix
sw <- 2.64
sx <- 1.63
cwx <- cxw <- .39 * sw * sx
## etc...
```


</div>


<div class='webex-solution'><button>solution</button>

```r
sw <- 2.64
sx <- 1.93
sy <- 2.10
sz <- 2.92
cwx <- cxw <- .39 * sw * sx
cwy <- cyw <- -.45 * sw * sy
cwz <- czw <- -.08 * sw * sz
cxy <- cyx <- -.40 * sx * sy
cxz <- czx <- -.07 * sx * sz
cyz <- czy <- -.23 * sy * sz

mx2 <- matrix(c(sw^2, cwx,  cwy,  cwz,
                cxw,  sx^2, cxy,  cxz,
                cyw,  cyx,  sy^2, cyz,
                czw,  czx,  czy,  sz^2),
              nrow = 4, byrow = TRUE)

set.seed(62)
simdata <- MASS::mvrnorm(10, mu = c(W = 5, X = -7, Y = 40, Z = -99), mx2)
```


</div>

:::

### Converting matrices to tibbles and combining with joins

Now that you know how to simulate data from multivariate normal distributions, an important coding skill is to convert these matrices to tabular data and then combine them with information in other tables using an `inner_join()`. We will call upon these skills in the next activity, when we simulate random intercepts and random slopes for a set of participants and then combine them with trial data. Here we'll just keep things simple so you can see the general approach.

First, to convert a matrix to a tibble, you can just use `as_tibble()`. However, when you're going to combine matrix data to another table, you need to have a 'key' column (such as participant ID) so that the values in the table can be appropriately matched. You can add this using `mutate()`, like below. Finally combine the information using the join. 

Walk through the code step by step and make sure you understand what each command is doing.


```r
# need for as_tibble(), %>%, mutate(), row_number(), inner_join()
library("tidyverse") 

## use the data from the 4x4 simulation above
## (see solution for definition of simdata matrix)
simtbl <- as_tibble(simdata) %>%
  mutate(id = row_number()) # the participant id (arbitrary)

## create a table we need to join to with trial information
trials <- tibble(id = rep(1:10, each = 10),
                 condition = rep(rep(c("test", "control"), each = 5), 10))

## now combine the information
combined <- inner_join(trials, simtbl, by = "id")

combined
```

```
## # A tibble: 100 × 6
##       id condition     W     X     Y     Z
##    <int> <chr>     <dbl> <dbl> <dbl> <dbl>
##  1     1 test       6.24 -3.06  39.6 -101.
##  2     1 test       6.24 -3.06  39.6 -101.
##  3     1 test       6.24 -3.06  39.6 -101.
##  4     1 test       6.24 -3.06  39.6 -101.
##  5     1 test       6.24 -3.06  39.6 -101.
##  6     1 control    6.24 -3.06  39.6 -101.
##  7     1 control    6.24 -3.06  39.6 -101.
##  8     1 control    6.24 -3.06  39.6 -101.
##  9     1 control    6.24 -3.06  39.6 -101.
## 10     1 control    6.24 -3.06  39.6 -101.
## # … with 90 more rows
```

