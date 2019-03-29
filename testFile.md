# testDoctor
#### What the Package Does (Title Case)
#####  0.1.0
*2019-03-28*





## test-creating_new_test 

### newtest1234 

```
expect_equal(10/2, 5) 
```
|Expectation           |Result  |
|:---------------------|:-------|
|expect_equal(10/2, 5) |success | 


### test123 

```
test1 <- 42
test2 <- 90
expect_equal(test1, test2) 
```
|Expectation                |Result                        |
|:--------------------------|:-----------------------------|
|expect_equal(test1, test2) |`test1` not equal to `test2`. | 


## test-test_rmd 

### multiplication works 

```
testvar <- 42
expect_equal(2 * 2, 4) 
```
|Expectation            |Result  |
|:----------------------|:-------|
|expect_equal(2 * 2, 4) |success | 


### multiple tests work! 

```
multitest <- TRUE
expect_equal(3 * 2, 6) 
```
|Expectation            |Result  |
|:----------------------|:-------|
|expect_equal(3 * 2, 6) |success | 


### One passes, one fails 

```
multitest <- TRUE
expect_equal(3 * 2, 6)
expect_equal(3 * 2, 42) 
```
|Expectation             |Result                 |
|:-----------------------|:----------------------|
|expect_equal(3 * 2, 6)  |success                |
|expect_equal(3 * 2, 42) |3 * 2 not equal to 42. | 

