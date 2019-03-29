
doctored_context <- function(desc) {
  cat(paste("##",desc,"\n\n"))
}

doctored_test_that <- function(desc, code) {

  code <- eval(substitute(substitute(code)))
  scribe<-test_scribe$new()
  testcodeOutput<-doc_test_code(code, env = parent.frame(),scribe=scribe)
  doctored_test_results(desc,code,scribe)
  # testcodeOutput
  # scribe$test_results
  # scribe
}


doc_test_code <- function(code, env = test_env(), skip_on_empty = TRUE, scribe) {

  ok <- TRUE

  register_expectation <- function(e,type) {
    calls <- e$expectation_calls
    srcref <- testthat:::find_first_srcref(calls)
    e <- testthat:::as.expectation(e, srcref = srcref)
    e$call <- calls
    e$start_frame <- attr(calls, "start_frame")
    e$end_frame <- e$start_frame + length(calls) - 1L
    ok <<- ok && testthat:::expectation_ok(e)
    scribe$add_result(result = e,type=type)
  }
  frame <- sys.nframe()

  frame_calls <- function(start_offset, end_offset, start_frame = frame) {
    sys_calls <- sys.calls()
    start_frame <- start_frame + start_offset
    structure(
      sys_calls[(start_frame):(length(sys_calls) - end_offset - 1)],
      start_frame = start_frame
    )
  }

  # Any error will be assigned to this variable first
  # In case of stack overflow, no further processing (not even a call to
  # signalCondition() ) might be possible
  test_error <- NULL

  expressions_opt <- getOption("expressions")
  expressions_opt_new <- min(expressions_opt + 500L, 500000L)

  # If no handlers are called we skip: BDD (`describe()`) tests are often
  # nested and the top level might not contain any expectations, so we need
  # some way to disable
  handled <- !skip_on_empty

  handle_error <- function(e) {
    handled <<- TRUE
    # First thing: Collect test error
    test_error <<- e

    # Increase option(expressions) to handle errors here if possible, even in
    # case of a stack overflow.  This is important for the DebugReporter.
    # Call options() manually, avoid withr overhead.
    options(expressions = expressions_opt_new)
    on.exit(options(expressions = expressions_opt), add = TRUE)

    # Capture call stack, removing last calls from end (added by
    # withCallingHandlers), and first calls from start (added by
    # tryCatch etc).
    e$expectation_calls <- frame_calls(11, 2)

    test_error <<- e

    # Error will be handled by handle_fatal() if this fails; need to do it here
    # to be able to debug with the DebugReporter
    register_expectation(e,"error")

    e$handled <- TRUE
    test_error <<- e
  }

  handle_fatal <- function(e) {
    handled <<- TRUE
    # Error caught in handle_error() has precedence
    if (!is.null(test_error)) {
      e <- test_error
      if (isTRUE(e$handled)) {
        return()
      }
    }

    if (is.null(e$expectation_calls)) {
      e$expectation_calls <- frame_calls(0, 0)
    }

    register_expectation(e,"fatal")
  }

  handle_expectation <- function(e) {
    handled <<- TRUE
    e$expectation_calls <- frame_calls(11, 6)
    register_expectation(e,"success")
    invokeRestart("continue_test")
  }

  handle_warning <- function(e) {
    # When options(warn) >= 2, a warning will be converted to an error.
    # So, do not handle it here so that it will be handled by handle_error.
    if (getOption("warn") >= 2) return()
    handled <<- TRUE
    e$expectation_calls <- frame_calls(11, 5)
    register_expectation(e,"warning")
    invokeRestart("muffleWarning")
  }

  handle_message <- function(e) {
    handled <<- TRUE
    invokeRestart("muffleMessage")
  }

  handle_skip <- function(e) {
    handled <<- TRUE

    if (inherits(e, "skip_empty")) {
      # Need to generate call as if from test_that
      e$expectation_calls <- frame_calls(0, 12, frame - 1)
    } else {
      e$expectation_calls <- frame_calls(11, 2)
    }

    register_expectation(e,"skip")
    signalCondition(e)
  }

  test_env <- new.env(parent = env)

  tryCatch(
    withCallingHandlers(
      {
        eval(code, test_env)
      },
      expectation = handle_expectation,
      skip =        handle_skip,
      warning =     handle_warning,
      message =     handle_message,
      error =       handle_error
    ),
    # some errors may need handling here, e.g., stack overflow
    error = handle_fatal,
    # skip silently terminate code
    skip  = function(e) {}
  )

  invisible(ok)
}
