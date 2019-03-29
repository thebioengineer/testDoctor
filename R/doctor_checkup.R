
test_check

doctor_checkup<-function(pkg=".",document=""){

  if(!is.character(document)){
    stop("document argument must either be an empty string or the path to an output file")
  }

  pkg <- devtools::as.package(pkg)
  ns_env <- devtools::load_all(pkg$path, quiet = TRUE)$env
  env <- new.env(parent = ns_env)
  testthat_args <- list(path=file.path(here::here(),"tests/testthat"), env = env)

  if (packageVersion("testthat") >= "1.0.2.9000") {
    testthat_args <- c(testthat_args, load_helpers = FALSE)
  }else if (packageVersion("testthat") > "1.0.2") {
    testthat_args <- c(testthat_args, load_helpers = FALSE)
  }

  testoutput<-capture.output({withr::with_options(c(useFancyQuotes = FALSE),
                      withr::with_envvar(
                        devtools::r_env_vars(),
                        do.call(testDoctor::doc_test_dir, testthat_args)))})

  if(document!=""){
    testoutput<-c(paste("#",pkg$package),
                  paste("####",pkg$title),
                  paste("##### ",pkg$version),
                  paste0("*",Sys.Date(),"*"),"\n\n\n\n",
                  testoutput)
  }

  cat(paste(testoutput,collapse="\n"),file = document)
}


#
# doctor_visit <- function(package,
#                        filter = NULL,
#                        reporter = check_reporter(),
#                        ...,
#                        stop_on_failure = TRUE,
#                        stop_on_warning = FALSE,
#                        wrap = TRUE,
#                        outputfile=paste0("test_results-",Sys.Date(),".md")) {
#   library(testthat)
#   require(package, character.only = TRUE)
#
#   env_test$in_test <- TRUE
#   env_test$package <- package
#   on.exit({
#     env_test$in_test <- FALSE
#     env_test$package <- NULL
#   })
#
#   test_path <- "testthat"
#   if (!utils::file_test("-d", test_path)) {
#     stop("No tests found for ", package, call. = FALSE)
#   }
#
#   testOutput<-capture.output({testDoctor::doc_test_dir(
#     path = test_path,
#     filter = filter,
#     reporter = reporter,
#     ...,
#     stop_on_failure = stop_on_failure,
#     stop_on_warning = stop_on_warning,
#     wrap = wrap
#   )})
#
#   write(testOutput)
#
# }
#

