# Interactions

## Resources

[Slides](slides/03_intx/index.html)

[My book chapter on interactions](https://psyteachr.github.io/stat-models-v1/interactions.html) provides an in-depth treatment

[Factorial web app](https://shiny.psy.gla.ac.uk/Dale/factorial2) allows you to play around with main effects and interactions in a 2x2 factorial design

## Activities


### Categorical-by-continuous interactions

:::{.try}

Are cat owners more frugal than dog owners? You run a study looking at the relationship between age (`AGE`) and net savings in British pounds sterling (`SAVE`) for dog versus cat owners (`HAS_DOG`: 0 = cat owner, 1 = dog owner). You run a multiple regression and get the following output (numbers are made up):

```
Call:
lm(formula = SAVE ~ HAS_DOG * AGE, data = dat)

Coefficients:
            Estimate Std.Error t value    Pr(>|t|)
(Intercept)   1043.3  58.28492   17.90 0.000000000
HAS_DOG        -97.8 -48.17734    2.03 0.042356539
AGE            165.9  53.51613    3.10 0.001935206
HAS_DOG:AGE    -14.1 -10.07143    1.40 0.161513318
```

**Answer the following questions about this output.**

What is the intercept of the regression line relating age to savings for cat owners (to 1 decimal place)?

<input class='webex-solveme nospaces' size='6' data-answer='["1043.3"]'/>


<div class='webex-solution'><button>solution</button>

```r
1043.3 # the value of `(Intercept)`
```

```
## [1] 1043.3
```


</div>

What is the slope of the regression line relating age to savings for cat owners?

<input class='webex-solveme nospaces' size='5' data-answer='["165.9"]'/>


<div class='webex-solution'><button>solution</button>

```r
165.9 # the value of the `AGE` coefficient
```

```
## [1] 165.9
```


</div>

How much savings does the model predict for a 46-year-old cat owner?

<input class='webex-solveme nospaces' size='6' data-answer='["8674.7"]'/>


<div class='webex-solution'><button>solution</button>

```r
1043.3 + 165.9 * 46 # = 8674.7
```


</div>

What is the intercept of the regression line relating age to savings for dog owners?

<input class='webex-solveme nospaces' size='5' data-answer='["945.5"]'/>


<div class='webex-solution'><button>solution</button>

```r
1043.3 + (-97.8) # = 945.5
```


</div>

What is the slope of the regression line relating age to savings for dog owners? (type the value)

<input class='webex-solveme nospaces' size='5' data-answer='["151.8"]'/>


<div class='webex-solution'><button>solution</button>

```r
165.9 + (-14.1) # = 151.8
```


</div>

How much savings would you predict for a 18-year-old dog owner? (type the value)

<input class='webex-solveme nospaces' size='6' data-answer='["3677.9"]'/>


<div class='webex-solution'><button>solution</button>

```r
(1043.3 - 97.8) + (165.9 - 14.1) * 18 # = 3677.9
```


</div>

True or false: The relationship between age and savings is statistically different for cat and dog owners ($\alpha = .05$).

<select class='webex-select'><option value='blank'></option><option value=''>TRUE</option><option value='answer'>FALSE</option></select>


<div class='webex-solution'><button>solution</button>


The statement is `FALSE` because the test of the null hypothesis for the interaction coefficient is not significant (p = .162).


</div>


:::

### Categorical-by-categorical interactions

For the next questions, assume that you are given **population means** that have been measured without error.

:::{.warning}

Note that with real data you will be dealing with **sample means** that have been measured with error rather than **population means**. With real data, you can't just look at the cell means to tell whether or not there is an effect. There may be a numerical difference, but you'd have to run an inferential test to see whether the difference is unlikely to be due to chance.

:::

#### Dataset 1

:::{.try}

Consider these population cell means from a 2x2 factorial design.

|   | B1| B2|
|:--|--:|--:|
|A1 | 83| 77|
|A2 | 83| 77|

Is there a main effect of A? <select class='webex-select'><option value='blank'></option><option value=''>TRUE</option><option value='answer'>FALSE</option></select>


<div class='webex-solution'><button>explanation</button>


FALSE. The mean of the row A1 is equal to the mean of A2, therefore no main effect of A.


</div>


Is there a main effect of B? <select class='webex-select'><option value='blank'></option><option value='answer'>TRUE</option><option value=''>FALSE</option></select>


<div class='webex-solution'><button>explanation</button>


TRUE. The mean of column B1 is not equal to the mean of column B2, therefore there is a main effect of B.


</div>


Is there an AB interaction? <select class='webex-select'><option value='blank'></option><option value=''>TRUE</option><option value='answer'>FALSE</option></select>


<div class='webex-solution'><button>explanation</button>


The simple effect of B at A1 is 83 - 77 = 6.

The simple effect of B at A2 is also 83 - 77 = 6.

The simple effects are the same, therefore no interaction. (FALSE)


</div>


:::

#### Dataset 2

:::{.try}

Consider these population cell means from a 2x2 factorial design.

|   | B1| B2|
|:--|--:|--:|
|A1 | 82| 92|
|A2 | 92| 82|

Is there a main effect of A? <select class='webex-select'><option value='blank'></option><option value=''>TRUE</option><option value='answer'>FALSE</option></select>


<div class='webex-solution'><button>explanation</button>


FALSE. The mean of the row A1 is equal to the mean of A2, therefore no main effect.


</div>


Is there a main effect of B? <select class='webex-select'><option value='blank'></option><option value=''>TRUE</option><option value='answer'>FALSE</option></select>


<div class='webex-solution'><button>explanation</button>


FALSE. The mean of column B1 is equal to the mean of column B2, therefore no main effect.


</div>


Is there an AB interaction? <select class='webex-select'><option value='blank'></option><option value=''>TRUE</option><option value='answer'>FALSE</option></select>


<div class='webex-solution'><button>explanation</button>


The simple effect of B at A1 is 82 - 92 = -10.

The simple effect of B at A2 is 92 - 82 = +10.

The simple effects are different, therefore interaction. (TRUE)


</div>


:::

#### Dataset 3

:::{.try}

Consider these population cell means from a 2x2 factorial design.

|   |  B1| B2|
|:--|---:|--:|
|A1 |  69| 85|
|A2 | 101| 93|

Is there a main effect of A? <select class='webex-select'><option value='blank'></option><option value='answer'>TRUE</option><option value=''>FALSE</option></select>


<div class='webex-solution'><button>explanation</button>


TRUE. The mean of the row A1 is NOT equal to the mean of A2, therefore main effect.


</div>


Is there a main effect of B? <select class='webex-select'><option value='blank'></option><option value=''>TRUE</option><option value='answer'>FALSE</option></select>


<div class='webex-solution'><button>explanation</button>


TRUE. The mean of column B1 is NOT equal to the mean of column B2, therefore main effect.


</div>


Is there an AB interaction? <select class='webex-select'><option value='blank'></option><option value=''>TRUE</option><option value='answer'>FALSE</option></select>


<div class='webex-solution'><button>explanation</button>


The simple effect of B at A1 is 69 - 85 = -16.

The simple effect of B at A2 is 101 - 93 = 8.

The simple effects are different, therefore interaction. (TRUE)


</div>


:::

### Coding categorical predictors in regression

:::{.try}

Imagine you have run a study with a 2x3 design (two factors, one with two levels and one with three levels). Copy the code below into your R session and run it to create the variable `facdata` in your session which contains the data for this hypothetical experiment.


```r
library("tidyverse")

facdata <- tibble(A = rep(c("A1", "A2"), each = 12),
                  B = rep(rep(c("B1", "B2", "B3"), each = 4), 2),
                  Y = c(9, 8, 7, 9, 4, 3, 4, 3, 6, 5, 6, 6,
                        4, 3, 4, 3, 9, 8, 7, 8, 5, 6, 6, 6))
```

Now use simple linear regression to test the main effect of A, main effect of B, and AxB interaction, and answer the following questions.

Is the main effect of A signficant? <select class='webex-select'><option value='blank'></option><option value=''>TRUE</option><option value='answer'>FALSE</option></select>

Is the main effect of B significant? <select class='webex-select'><option value='blank'></option><option value=''>TRUE</option><option value='answer'>FALSE</option></select>

Is the AxB interaction significant? <select class='webex-select'><option value='blank'></option><option value='answer'>TRUE</option><option value=''>FALSE</option></select>


<div class='webex-solution'><button>solution</button>


- main effect of A: **FALSE**
- main effect of B: **FALSE**
- AxB interaction: **TRUE**

Here's how to perform the analysis.

First, need to deviation code (or sum code) numeric predictor variables.


```r
facdev <- facdata %>%
  mutate(Ad = if_else(A == "A2", 1/2, -1/2),
         B2vB1 = if_else(B == "B2", 2/3, -1/3),
         B3vB1 = if_else(B == "B3", 2/3, -1/3))

## double check (important!)
facdev %>%
  distinct(A, B, Ad, B2vB1, B3vB1)
```

```
## # A tibble: 6 × 5
##   A     B        Ad  B2vB1  B3vB1
##   <chr> <chr> <dbl>  <dbl>  <dbl>
## 1 A1    B1     -0.5 -0.333 -0.333
## 2 A1    B2     -0.5  0.667 -0.333
## 3 A1    B3     -0.5 -0.333  0.667
## 4 A2    B1      0.5 -0.333 -0.333
## 5 A2    B2      0.5  0.667 -0.333
## 6 A2    B3      0.5 -0.333  0.667
```

Now let's fit the base model with all the predictors.


```r
## fit a model
mod <- lm(Y ~ (B2vB1 + B3vB1) * Ad, facdev)

summary(mod)
```

```
## 
## Call:
## lm(formula = Y ~ (B2vB1 + B3vB1) * Ad, data = facdev)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
##  -1.25  -0.50   0.25   0.50   1.00 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  5.79167    0.13819  41.910  < 2e-16 ***
## B2vB1       -0.12500    0.33850  -0.369    0.716    
## B3vB1       -0.12500    0.33850  -0.369    0.716    
## Ad          -0.08333    0.27639  -0.302    0.766    
## B2vB1:Ad     9.25000    0.67700  13.663 6.08e-11 ***
## B3vB1:Ad     4.75000    0.67700   7.016 1.51e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.677 on 18 degrees of freedom
## Multiple R-squared:  0.9122,	Adjusted R-squared:  0.8878 
## F-statistic:  37.4 on 5 and 18 DF,  p-value: 6.764e-09
```

Use model comparison to test effects. First, main effect of A.


```r
mod_noA <- update(mod, . ~ . -Ad)

anova(mod, mod_noA)
```

```
## Analysis of Variance Table
## 
## Model 1: Y ~ (B2vB1 + B3vB1) * Ad
## Model 2: Y ~ B2vB1 + B3vB1 + B2vB1:Ad + B3vB1:Ad
##   Res.Df    RSS Df Sum of Sq      F Pr(>F)
## 1     18 8.2500                           
## 2     19 8.2917 -1 -0.041667 0.0909 0.7665
```

Now main effect of B.


```r
mod_noB <- update(mod, . ~ . -B2vB1 -B3vB1)

anova(mod, mod_noB)
```

```
## Analysis of Variance Table
## 
## Model 1: Y ~ (B2vB1 + B3vB1) * Ad
## Model 2: Y ~ Ad + B2vB1:Ad + B3vB1:Ad
##   Res.Df    RSS Df Sum of Sq      F Pr(>F)
## 1     18 8.2500                           
## 2     20 8.3333 -2 -0.083333 0.0909 0.9135
```

Finally, AxB interaction.


```r
mod_noAB <- update(mod, . ~ . -B2vB1:Ad -B3vB1:Ad)

anova(mod, mod_noAB)
```

```
## Analysis of Variance Table
## 
## Model 1: Y ~ (B2vB1 + B3vB1) * Ad
## Model 2: Y ~ B2vB1 + B3vB1 + Ad
##   Res.Df    RSS Df Sum of Sq      F   Pr(>F)    
## 1     18  8.250                                 
## 2     20 93.833 -2   -85.583 93.364 3.14e-10 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```


</div>


:::

