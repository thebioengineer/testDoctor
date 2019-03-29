context("test-test_rmd")

test_that("multiplication works", {
  testvar<-42
  expect_equal(2 * 2, 4)
})

test_that("multiple tests work!", {
  multitest<-TRUE
  expect_equal(3 * 2, 6)
})


test_that("One passes, one fails", {
  multitest<-TRUE
  expect_equal(3 * 2, 6)
  expect_equal(3 * 2, 42)

})



test_that("Test Large Test Inputs", {

  x<-data.frame(x=runif(25),
             y=LETTERS[1:25])


  expect_equal(x, data.frame(x=runif(25),
                             y=LETTERS[25:1]))

})
