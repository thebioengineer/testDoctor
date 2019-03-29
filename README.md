# testDoctor

Below is a sample of a report that would be generated by testDoctor::doctor_checkup(). To send the output to a file, use the "document" argument to generate a markdown, and the "compile" tag to render the output into a pdf, html, or word document using the rmarkdown::render syntax.



# testDoctor
#### description: Generates markdown Documents of the test results using the testthat infrastructure
##### version:  0.1.0
*2019-03-28*

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

