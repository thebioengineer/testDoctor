#' Run all tests in directory or package and document results
#'
#' @description
#' Use `doc_test_dir()` for a collection of tests in a directory
#'
#' Provides an alternate to the test_dir functionality in the `testhat` package,
#' and generates more thorough documentation surrounding the tests.
#'
#' @param path path to tests
#' @param package   package name
#' @param filter If not `NULL`, only tests with file names matching this
#'   regular expression will be executed.  Matching will take on the file
#'   name after it has been stripped of `"test-"` and `".R"`.
#' @param ... Additional arguments passed to [grepl()] to control filtering.

#'   warnings.
#' @inheritParams doc_file
#'
#' @export
#' @examples
#' \dontrun{test_package("testDoctor")}

doc_test_dir <-function (path, filter = NULL,
                      env = test_env(), ...,
                      encoding = "unknown",
                      load_helpers = TRUE,
                      stop_on_failure = FALSE,
                      stop_on_warning = FALSE,
                      wrap = TRUE) {

  if (!missing(encoding) && !identical(encoding, "UTF-8")) {
    warning("`encoding` is deprecated; all files now assumed to be UTF-8",
            call. = FALSE)
  }
  if (load_helpers) {
    source_test_helpers(path, env)
  }

  #setup and teardown tests
  source_test_setup(path, env)
  on.exit(source_test_teardown(path, env), add = TRUE)

  withr::local_envvar(list(R_TESTS = "", TESTTHAT = "true"))

  if (identical(Sys.getenv("NOT_CRAN"), "true")) {
    withr::local_options(list(lifecycle_verbose_retirement = TRUE))
  }

  paths <- find_test_scripts(path, filter, ...)

  doc_test_files(paths, env = env, stop_on_failure = stop_on_failure,
             stop_on_warning = stop_on_warning, wrap = wrap)
}

