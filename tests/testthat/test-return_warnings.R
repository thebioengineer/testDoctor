context("test-return_warnings")

test_that("Check for warning handling", {
  expect_equal(as.numeric(c("1","nA2","3")), c(1,NA,3))
})
