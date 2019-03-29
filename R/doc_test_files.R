
#' Run all tests listed in the files
#'
#' Evaluates each of the tests in each file passed to paths
#'
#' @param paths paths to each test file
#' @param env testing env

#'   warnings.
#' @inheritParams doc_test_file
#'
#' @export
#' @examples
#' \dontrun{doc_test_dir("tests/testthat")}
doc_test_files <- function(paths,
                       env = test_env(),
                       stop_on_failure = FALSE,
                       stop_on_warning = FALSE,
                       wrap = TRUE) {

  if (length(paths) == 0) {
    stop("No matching test file in dir")
  }

  results <- lapply(
      paths,
      doc_test_file,
      env = env,
      wrap = wrap
      )

  # results <- testthat:::testthat_results(results)

  # if (stop_on_failure && sum(unlist(results))==length()) {
  #   stop("Test failures", call. = FALSE)
  # }
  # if (stop_on_warning && testthat:::any_warnings(results)) {
  #   stop("Tests generated warnings", call. = FALSE)
  # }

  invisible(results)
}
