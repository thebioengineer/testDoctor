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