#' Run all tests in specified file.
#'
#' @param path path to file

#' @param env environment in which to execute the tests
#' @param load_helpers Source helper files before running the tests?
#' @param encoding File encoding, default is "unknown"
#' `unknown`.
#' @param stop_on_failure If `TRUE`, throw an error if any tests fail.
#' @param stop_on_warning If `TRUE`, throw an error if any tests generate
#' @param wrap Automatically wrap all code within [test_that()]? This ensures
#'   that all expectations are reported, even if outside a test block.
#'
#' @return the results as a "testthat_results" (list)
#' @export
doc_test_file <- function(path,
                          env = test_env(),
                          load_helpers = TRUE,
                          encoding = "UTF-8", wrap = TRUE) {
  library(testthat)
  library(testDoctor)

  if (!file.exists(path)) {
    stop("`path` does not exist", call. = FALSE)
  }

  if (!missing(encoding) && !identical(encoding, "UTF-8")) {
    warning("`encoding` is deprecated; all files now assumed to be UTF-8", call. = FALSE)
  }

  if (load_helpers) {
    testthat:::source_test_helpers(dirname(path), env = env)
  }

  on.exit(testthat:::teardown_run(dirname(path)), add = TRUE)

  doc_source_file(
    path, new.env(parent = env),
    chdir = TRUE, wrap = wrap
    )
}
