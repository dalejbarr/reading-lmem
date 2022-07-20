# Regression basics

[Slides](slides/01_intro/index.html)

[GLM web app](https://shiny.psy.gla.ac.uk/Dale/GLM)

## Activities

The following activities are intended to help you ease into regression in R. We'll start out by learning how to simulate univariate data and build simple tables (or "tibbles", in R tidyverse speak). Then we'll simulate some data from a simple regression with a single response and single predictor. Next, we'll see how to generate predicted values, extract residuals, and check diagnostics. 

Make sure you've loaded the tidyverse package before you begin. You'll need it for the `tibble()` function.


```r
library("tidyverse")
```

### Simulating discrete data

It is sometimes useful just to randomly sample things from a set, with uniform probability for each value. The `sample()` function is useful for this.

Take a moment and look at the help page for this function (`?sample`) before attempting the next task.

:::{.try}

**Simulate the outcome of 20 rolls of a six-sided die.**


<div class='webex-solution'><button>solution</button>

```r
sample(1:6, 20, TRUE)
```

```
##  [1] 3 5 3 3 3 3 5 2 5 5 5 4 3 1 6 3 3 4 6 2
```


</div>

:::

:::{.info}

**On random number generation.**

Random number generation is designed to give you different results every time.

If you want to get the same result, you can 'seed' the random number generator with a particular integer value. This can be any integer value up to `.Machine$integer.max` which on my machine is equal to 2147483647.

A demonstration:


```r
set.seed(999)

sample(1:10) # generates a permutation of the values
```

```
##  [1]  4  7  1  6  8  2  5 10  9  3
```


```r
sample(1:10) # different results from above
```

```
##  [1]  8  5  7  6 10  3  9  2  1  4
```


```r
set.seed(999) # setting the seed, so we should get the same
              # as we did the first time

sample(1:10)
```

```
##  [1]  4  7  1  6  8  2  5 10  9  3
```

:::


By default, `sample()` chooses elements from the set with uniform probability. We can change this using the `prob` argument of `sample()`.

:::{.try}

**Simulate the random sampling of 20 pet owners from a population where 70% of owners have cats and 30% have dogs.**


<div class='webex-solution'><button>solution</button>

```r
sample(c("cat owner", "dog owner"), 20, TRUE, prob = c(.7, .3))
```

```
##  [1] "cat owner" "dog owner" "cat owner" "dog owner" "cat owner" "dog owner"
##  [7] "cat owner" "cat owner" "dog owner" "cat owner" "cat owner" "cat owner"
## [13] "dog owner" "dog owner" "cat owner" "cat owner" "dog owner" "cat owner"
## [19] "cat owner" "cat owner"
```


</div>
:::

### Simulating normally distributed continuous data

The `rnorm()` function can be used to simulate data from a normal distribution. Have a look at the help page for the function (type `?rnorm` in the console).

:::{.try}

**Simulate 10 observations from a normal distribution with a mean of 5 and a standard deviation of 3.**


<div class='webex-solution'><button>solution</button>

```r
rnorm(10, mean = 5, sd = 3)
```

```
##  [1]  5.205005  5.301973  7.704034 -1.223071  1.314310  6.929133  3.920711
##  [8]  5.882107  1.624195  6.926797
```


</div>

:::


:::{.try}

**Simulate 40 observations with a mean of 0 and standard deviation of 7.**


<div class='webex-solution'><button>solution</button>

```r
rnorm(40, sd = 7) ## note we just use the default for 'mean'
```

```
##  [1]  -7.74716306  -6.19388274 -10.87866601  -0.88675292  16.67864909
##  [6]   4.20893271   1.25552887   7.56372039  -1.72768474 -14.79615893
## [11]  -2.59369230   3.66007455   3.62463875  -9.81757611  -3.39945708
## [16]   0.05948697  -8.97479301  -7.78105188   2.10465787   1.93535191
## [21] -14.35614361   0.09933148   4.07586534  -0.24308471  -0.81664903
## [26]  -4.51487461  12.21088120   2.56266132  -0.46766948   1.97828726
## [31]   3.97386622  -8.95451128   3.04758166  -3.95850688  -6.46317949
## [36]   8.15467802   7.29448078   7.72679854  -0.13002474  -8.02870368
```


</div>

:::

### Putting things into a table (or `tibble`)

Most of what you will be working with when doing regression is *tabular data*; data arranged in the form of a table.

Tabular data structures, like lists, allow for a collection of data of different types (characters, integers, logical, etc.) but subject to the constraint that each "column" of the table (element of the list) must have the same number of elements.  The base R version of a table is called a `data.frame` while the 'tidyverse' version is called a `tibble`.  Tibbles are far easier to work with, so we'll be using those. To learn more about differences between these two data structures, see `vignette("tibble")`.

Although we'll often be loading data into tibble (e.g., using `read_csv()`), it is also useful to be able to create your own tibbles by typing in data. For this, we will use the `tibble()` function.

:::{.try}

**Use `tibble()` to create a tibble with the name, age, and sex of 3-5 people whose names, ages, and sex you know.**


<div class='webex-solution'><button>example solution</button>

```r
family <- tibble(name = c("Jorge", "Esther", "Mel"),
                 age = c(40, 41, 20),
                 sex = c("male", "female", "male") )

# also note:
# you can type this in row by row, rather than column by column,
# using the 'tribble' function. See ?tribble 
family <- tribble(~name,  ~age, ~sex,
                  "Jorge",   40,  "male",
                  "Esther",  41,  "female",
                  "Mel",     20,  "male")
```


</div>
:::

:::{.try}

**Convert the built-in base R `iris` dataset to a tibble, and store it in the variable `iris2`.**


<div class='webex-solution'><button>hint</button>


`as_tibble()`


</div>



<div class='webex-solution'><button>solution</button>

```r
iris2 <- as_tibble(iris)
```


</div>

:::

:::{.try}

**Create a tibble that has the structure of the table below, using the minimum typing possible. (Hint: `rep()`).  Store it in the variable `my_tbl`.**


```
## # A tibble: 8 × 4
##      ID A     B     C    
##   <int> <chr> <chr> <chr>
## 1     1 A1    B1    C1   
## 2     2 A1    B2    C1   
## 3     3 A1    B1    C1   
## 4     4 A1    B2    C1   
## 5     5 A2    B1    C1   
## 6     6 A2    B2    C1   
## 7     7 A2    B1    C1   
## 8     8 A2    B2    C1
```


<div class='webex-solution'><button>solution</button>

```r
my_tbl <- tibble(ID = 1:8,
                 A = rep(c("A1", "A2"), each = 4),
                 B = rep(c("B1", "B2"), 4),
                 C = "C1")    
```


</div>

:::

### Simulating data from the linear model

A simple regression model with a single predictor is of the form

$Y_i = \beta_0 + \beta_1 X_i + e_i$

where:

- $Y_i$ is the value of the response variable for each observation $i$;
- $X_i$ is the value of the predictor variable for observation $i$;
- $\beta_0$ and $\beta_1$ are regression coefficients for the intercept and slope of the regression line;
- $e_i$ is the error for observation $i$ (divergence from the model's fitted value from the regression line).

We assume that the errors are $N \sim \left(0, \sigma^2\right)$; that is, that the errors are distributed according to a normal distribution with mean of zero and a variance of $\sigma^2$. Note that the **variance** is just the square of the standard deviation; i.e., the standard deviation is $\sigma$.

Note also that the model doesn't make any assumptions about the distribution of the predictor variables; the $X_i$ values can have any distribution.

OK, with these things in mind, and using the skills you've learned above to simulate data and construct tibbles, your next task is to:

:::{.try}

Make a tibble that contains 50 observations simulated according to the regression model

$Y_i = 300 - 75 X_i + e_i$

where $\sigma^2 = 100$ and the $X_i$ values are integers from 1 to 10 with uniform probability.

Store the resulting tibble in a variable `simdata` with response variable `y` and predictor variable `x`.


<div class='webex-solution'><button>hint</button>

```r
simdata <- tibble(x = sample( ??? ),
                  e = rnorm( ??? ),
                  y = 300...???)
```


</div>


<div class='webex-solution'><button>solution</button>

```r
## make sure you have loaded the tidyverse [library("tidyverse")]
simdata <- tibble(x = sample(1:10, 50, replace = TRUE),
                  e = rnorm(50, 0, sqrt(100)),
                  y = 300 - 75 * x + e)

simdata
```

```
## # A tibble: 50 × 3
##        x       e     y
##    <int>   <dbl> <dbl>
##  1     9   8.71  -366.
##  2    10  -6.85  -457.
##  3    10   0.234 -450.
##  4     9  -6.32  -381.
##  5     1  -6.75   218.
##  6     9 -21.5   -397.
##  7     9   9.89  -365.
##  8     1   1.18   226.
##  9     8 -10.3   -310.
## 10     2  20.6    171.
## # … with 40 more rows
```


</div>

:::

### Estimate the regression coefficients

:::{.try}

**Use the `lm()` function to estimate the regression coefficients (intercept and slope) for the `x` and `y` variables in the data you just generated (`simdata`). Store the result in the a variable named `fitted_model`. Print the model output using `summary()`. How well do the values match what you put in?**


<div class='webex-solution'><button>solution</button>

```r
fitted_model <- lm(y ~ x, data = simdata)

summary(fitted_model)
```

```
## 
## Call:
## lm(formula = y ~ x, data = simdata)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -20.1905  -6.6329   0.0272   6.6469  20.5421 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 300.4343     2.9584   101.6   <2e-16 ***
## x           -75.1941     0.4267  -176.2   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 9.122 on 48 degrees of freedom
## Multiple R-squared:  0.9985,	Adjusted R-squared:  0.9984 
## F-statistic: 3.106e+04 on 1 and 48 DF,  p-value: < 2.2e-16
```


</div>

:::

### Deriving predictions

The `fitted()` function gives you fitted values for the model; `residuals()` gives you residuals. Try these out.

The `predict.lm()` function (or just `predict()`) makes it possible to derive predicted values from the model. To make predictions, you have to create a tibble with values for your predictor variable (`x` in this case).

:::{.try}

**Generate predicted values from `fitted_model` for integer values of X from 1 to 20.**


<div class='webex-solution'><button>solution</button>

```r
new_data <- tibble(x = 1:20)

predict(fitted_model, new_data)
```

```
##             1             2             3             4             5 
##   225.2402518   150.0461729    74.8520941    -0.3419848   -75.5360637 
##             6             7             8             9            10 
##  -150.7301425  -225.9242214  -301.1183002  -376.3123791  -451.5064579 
##            11            12            13            14            15 
##  -526.7005368  -601.8946156  -677.0886945  -752.2827734  -827.4768522 
##            16            17            18            19            20 
##  -902.6709311  -977.8650099 -1053.0590888 -1128.2531676 -1203.4472465
```


</div>

:::

### Model diagnostics

The `plot()` method for fitted model objects gives you some diagnostic information. Probably the most important plot is the QQ (Quantile/Quantile), which plots the empirical quantiles against the theoretical quantiles from a normal distribution. You can create this plot using `qqnorm()`. Try these out.
