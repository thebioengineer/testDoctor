## test-creating_new_test 

### newtest1234 
```r
expect_equal(10/2, 5) 
```
|Expectation           |Result  |
|:---------------------|:-------|
|expect_equal(10/2, 5) |success | 


### test123 
```r
test1 <- 42
test2 <- 90
expect_equal(test1, test2) 
```
|Expectation                |Result                        |
|:--------------------------|:-----------------------------|
|expect_equal(test1, test2) |`test1` not equal to `test2`. | 


## test-return_warnings 

### Check for warning handling 
```r
expect_equal(as.numeric(c("1", "nA2", "3")), c(1, NA, 3)) 
```
|Expectation                                               |Result  |
|:---------------------------------------------------------|:-------|
|expect_equal(as.numeric(c("1", "nA2", "3")), c(1, NA, 3)) |success | 


## test-test_rmd 

### multiplication works 
```r
testvar <- 42
expect_equal(2 * 2, 4) 
```
|Expectation            |Result  |
|:----------------------|:-------|
|expect_equal(2 * 2, 4) |success | 


### multiple tests work! 
```r
multitest <- TRUE
expect_equal(3 * 2, 6) 
```
|Expectation            |Result  |
|:----------------------|:-------|
|expect_equal(3 * 2, 6) |success | 


### One passes, one fails 
```r
multitest <- TRUE
expect_equal(3 * 2, 6)
expect_equal(3 * 2, 42) 
```
|Expectation             |Result                 |
|:-----------------------|:----------------------|
|expect_equal(3 * 2, 6)  |success                |
|expect_equal(3 * 2, 42) |3 * 2 not equal to 42. | 


### Test Large Test Inputs 
```r
x <- data.frame(x = runif(25), y = LETTERS[1:25])
expect_equal(x, data.frame(x = runif(25), y = LETTERS[25:1])) 
```
|Expectation                                                   |Result                                                         |
|:-------------------------------------------------------------|:--------------------------------------------------------------|
|expect_equal(x, data.frame(x = runif(25), y = LETTERS[25:1])) |`x` not equal to data.frame(x = runif(25), y = LETTERS[25:1]). | 

