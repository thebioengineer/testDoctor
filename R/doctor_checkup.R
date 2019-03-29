#' Run all tests in directory or package, and generage nice documentation
#'
#' @description
#' Use `doctor_checkup()` for a collection of tests in a directory;
#'
#' Framework is built to work on top of the `testthat` library, so no changes to your tests need to be made to make this work.
#' Your outputs will be saved to a markdown document in the tests folder
#'
#' @param pkg path to package
#' @param document the name of the document to write to. If left as "", writes to console.
#' @param compile the name of the document to write to. If left as "", writes to console.

#' @export
#'
#' @import devtools
#' @import here
#' @import withr
#' @importFrom rmarkdown pandoc_convert

doctor_checkup<-function(pkg=".",document="",compile=NULL){

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
    testoutput<-c(paste("# Package:",pkg$package),
                  paste("#### Title:",pkg$title),
                  paste("##### Version:",pkg$version),
                  paste0("*",Sys.Date(),"*"),"\n\n",
                  testoutput)
  }

  cat(paste(testoutput,collapse="\n"),file = document)

  if(!is.null(compile) & document != ""){
    rmarkdown::render(document,output_format = compile)
  }
}


#' @export
doctor_visit <- function(package,
                       filter = NULL,
                       ...,
                       stop_on_failure = TRUE,
                       stop_on_warning = FALSE,
                       wrap = TRUE) {

  library(testthat)
  library(testDoctor)

  require(package, character.only = TRUE)

  Doctors_office$in_test <- TRUE
  Doctors_office$package <- package
  on.exit({
    Doctors_office$in_test <- FALSE
    Doctors_office$package <- NULL
  })

  test_path <- "testthat"
  if (!utils::file_test("-d", test_path)) {
    stop("No tests found for ", package, call. = FALSE)
  }

  testoutput<-capture.output({testDoctor::doc_test_dir(
    path = test_path,
    filter = filter,
    stop_on_failure = stop_on_failure,
    stop_on_warning = stop_on_warning,
    wrap = wrap
  )})

  test_results<-"testDoctor_Results"
  if(!dir.exists(test_results)){
    dir.create(test_results)
  }

  pkg<-packageDescription(package)


  testoutput<-c(paste("# Package:",pkg$Package),
                paste("#### Title:",pkg$Title),
                paste("##### Version:",pkg$Version),
                paste0("*",Sys.Date(),"*"),"\n\n",
                testoutput)

  cat(paste(testoutput,collapse="\n"),file = file.path(test_results,"test_Results.md"))

  rmarkdown::render(file.path(test_results,"test_Results.md"),
                    output_format = "pdf_document")


  file.rename(from = file.path(test_results,"test_Results.pdf"),
              to = file.path(test_results,paste0("test_Results-",Sys.Date(),".pdf")))
}

# Environment utils -------------------------------------------------------

Doctors_office <- new.env(parent = emptyenv())
Doctors_office$in_test <- FALSE
Doctors_office$package <- NULL
