# Linear mixed-effects models

## Resources

[Slides](slides/06_lmm1/index.html)

[My book chapter](https://psyteachr.github.io/stat-models-v1/introducing-linear-mixed-effects-models.html) contains in-depth discussion and links to further resources.

[A web application](https://shiny.psy.gla.ac.uk/Dale/multilevel) that allows you to simulate sleepstudy data and adjust the parameters and compare complete pooling, no pooling, and partial pooling (mixed-effects) models.

## Activities

### Data simulation

The general GLM for the sleepstudy data was:

$$Y_{ij} = \beta_0 + \beta_1 X_{ij} + e_{ij}$$

$$\beta_0 = \gamma_{00} + S_{0i}$$

$$\beta_1 = \gamma_{10} + S_{1i}$$

$$\left< S_{0i}, S_{1i} \right> \sim N\left(\left<0, 0\right>, \mathbf \Sigma\right)$$

$$\mathbf\Sigma = \left(\begin{array}{cc}{\tau_{00}}^2 & \rho\tau_{00}\tau_{11}\\\rho\tau_{00}\tau_{11} & {\tau_{11}}^2\end{array}\right)$$

$$e_{ij} \sim N(0, \sigma^2).$$

In this part, we will be making our own simulated `sleepstudy` data for 18 subjects.  Your parameter values should reflect the data-generating process below:

$$Y_{ij} = \beta_0 + \beta_1 X_{ij} + e_{ij}$$
$$\beta_0 = 310 + S_{0i}$$
$$\beta_1 = 4 + S_{1i}$$
$$\left< S_{0i}, S_{1i} \right> \sim N\left(\left<0, 0\right>, \mathbf \Sigma\right)$$
$$\mathbf\Sigma = \left(\begin{array}{cc}{30}^2
& (0.9)(30)(33)\\
(0.9)(30)(33) & 
{33}^2\end{array}\right)$$
$$e_{ij} \sim N(0, 25^2)\\$$

We will proceed in three steps.

1. Generate random effects (intercept and slope offsets) for 18 subjects from a bivariate normal distribution using the parameter values for the variance components.

2. Generate a tibble containing the fixed effects $\gamma_{00}$ and $\gamma_{10}$, and random noise according to the value of $\sigma^2$.

3. Combine the random effects generated in part 1 with the fixed effects and error generated in part 2, and calculate the $Y$ values according to the DGP.

**Setting up.** Load tidyverse, lme4, and set the random number seed.


```r
library("lme4")
library("tidyverse")

set.seed(62)
```

#### Step 1: Generate random effects

:::{.try}

You will need to generate data for a matrix called `rmx`, where the first column should have the random intercepts $S_{0i}$ and the second column should have the random slopes $S_{1i}$.


<div class='webex-solution'><button>hint</button>


Look back at [the last chapter](variance-covariance.html). You'll need to use `rbind()` and `MASS::mvrnorm()`.


</div>



<div class='webex-solution'><button>solution</button>

```r
covmx <- rbind(c(30^2, .9 * 30 * 33),
               c(.9 * 30 * 33, 33^2))

## 'rmx' should be an 18x2 matrix
rmx <- MASS::mvrnorm(18, mu = c(S0i = 0, S1i = 0),
                     Sigma = covmx)
```


</div>
:::

#### Step 2: Make a tibble with fixed effects and random error (noise)

:::{.try}

In the next chunk, make a table containing the values for $\gamma_{00}$, $\gamma_{10}$, and $e_{ij}$.

This should be a tibble with 180 observations (18 subjects, observed over 10 days). The target table structure is shown below (your values for e_ij will vary because they are randomly generated).




```
## # A tibble: 180 x 5
##    Subject  Days gamma_00 gamma_10    e_ij
##    <fct>   <int>    <dbl>    <dbl>   <dbl>
##  1 1           0      310        4  28.6  
##  2 1           1      310        4 -20.0  
##  3 1           2      310        4  17.8  
##  4 1           3      310        4   0.363
##  5 1           4      310        4  26.6  
##  6 1           5      310        4  -4.06 
##  7 1           6      310        4 -18.3  
##  8 1           7      310        4   7.09 
##  9 1           8      310        4  -4.84 
## 10 1           9      310        4  38.7  
## # … with 170 more rows
```


<div class='webex-solution'><button>hint</button>


Something like: `tibble(... e_ij = rnorm(...))`


</div>




<div class='webex-solution'><button>solution</button>

```r
obs <- tibble(Subject = factor(rep(seq_len(18), each = 10)),
              Days = rep(0:9, 18),
              gamma_00 = 310,  # replace with correct values
              gamma_10 = 4,  # replace with correct values
              e_ij = rnorm(18 * 10, 0, 25))      # replace with correct values
```


</div>
:::

#### Step 3: Combine

:::{.try}
Now find a way to combine the information in the `obs` table with the info in `rmx` so that you create a table that looks like the `sleepstudy` table. (*Hint: this is where the information at the end of the [last chapter](https://dalejbarr.github.io/reading-lmem/variance-covariance-matrices.html#converting-matrices-to-tibbles-and-combining-with-joins) will come in handy.*)

The resulting `simdata` table should *only* have the columns `Reaction`, `Days`, and `Subject`. Hint: check the simulated tables of data in the [multilevel web app](https://shiny.psy.gla.ac.uk/Dale/multilevel).


<div class='webex-solution'><button>hint</button>



```r
rmx_tbl <- as_tibble() %>%
  mutate(??)

simdata <- inner_join(?, ?, "?") %>%
  mutate(Reaction = .....??) %>%
  select(...)
```


</div>



<div class='webex-solution'><button>solution</button>

```r
rmx_tbl <- rmx %>%
  as_tibble() %>%
  mutate(Subject = factor(1:18))

simdata <- inner_join(obs, rmx_tbl, "Subject") %>%
  mutate(Reaction = gamma_00 + S0i + (gamma_10 + S1i) * Days + e_ij) %>%
  select(Subject, Days, Reaction)

simdata
```

```
## # A tibble: 180 x 3
##    Subject  Days Reaction
##    <fct>   <int>    <dbl>
##  1 1           0     353.
##  2 1           1     342.
##  3 1           2     418.
##  4 1           3     438.
##  5 1           4     502.
##  6 1           5     509.
##  7 1           6     532.
##  8 1           7     595.
##  9 1           8     621.
## 10 1           9     702.
## # … with 170 more rows
```


</div>
:::

### Estimate the model

:::{.try}
Now we're going to try to recover the original population parameters from the sample. Let's see how close we get.

Just so we're all working with the same data, let's work with some different data `simdata2` that you'll need to [download](data/simdata2.rds){target="_download"}, place in your working directory, and import using the code below.




```r
simdata2 <- readRDS("simdata2.rds")
```

Now use the `lmer()` function from *`{lme4}`* to estimate the population parameters for `simdata2`. Print out the results using `summary()`.




<div class='webex-solution'><button>solution</button>

```r
sleepmod <- lmer(Reaction ~ Days + (Days | Subject),
                 data = simdata2)

summary(sleepmod)
```

```
## Linear mixed model fit by REML ['lmerMod']
## Formula: Reaction ~ Days + (Days | Subject)
##    Data: simdata2
## 
## REML criterion at convergence: 1799.1
## 
## Scaled residuals: 
##      Min       1Q   Median       3Q      Max 
## -2.51460 -0.59435 -0.01494  0.60344  2.43897 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev. Corr
##  Subject  (Intercept)  984.1   31.37        
##           Days        1270.1   35.64    0.88
##  Residual              680.9   26.09        
## Number of obs: 180, groups:  Subject, 18
## 
## Fixed effects:
##             Estimate Std. Error t value
## (Intercept)  306.741      8.231  37.268
## Days           5.493      8.427   0.652
## 
## Correlation of Fixed Effects:
##      (Intr)
## Days 0.757
```


</div>
:::



:::{.try}

Now let's identify the estimates of the DGP in the output. Type in the values (rounded to one decimal point).

| Parameter     | Population Value |      Estimate          |
|:--------------|-----------------:|-----------------------:|
| $\gamma_{00}$ |              310 | <input class='webex-solveme nospaces' data-tol='0.2' size='16' data-answer='["306.740572663889"]'/>  |
| $\gamma_{10}$ |              4   | <input class='webex-solveme nospaces' data-tol='0.2' size='16' data-answer='["5.49316399909361"]'/>  |
| $\tau_{00}$   |              30  | <input class='webex-solveme nospaces' data-tol='0.2' size='16' data-answer='["31.3710206322219"]'/>  |
| $\tau_{11}$   |              33  | <input class='webex-solveme nospaces' data-tol='0.2' size='16' data-answer='["35.6390378256499"]'/>  |
| $\rho$        |              .9  | <input class='webex-solveme nospaces' data-tol='0.2' size='17' data-answer='["0.878787903597919",".878787903597919"]'/>  |
| $\sigma$      |              25  | <input class='webex-solveme nospaces' data-tol='0.2' size='15' data-answer='["26.094061637718"]'/>  |
:::
