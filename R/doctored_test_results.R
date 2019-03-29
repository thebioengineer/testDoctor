

#' print the results of the Tests
#'
#' @param desc description of test, from test_that
#' @param code test code to be converted to text from test_that
#' @param scribe test_scribe object containing results of test
#'
#' @return NULL
#' @import knitr
#' @export
doctored_test_results<-function(desc,code,scribe){

  results<-scribe$return_results()
  names(results)<-c("Expectation","Result")
  results$Result<-gsub("\\n.*$","",results$Result)

  cat(paste("###",desc,"\n"))
  cat("```r\n")
  cat(paste(code[-1],collapse = "\n"),"\n\n")
  cat("```\n")
  cat(paste(knitr::kable(results, format = "markdown",row.names=FALSE),collapse = "\n"),"\n")
  cat("\n\n")
}
