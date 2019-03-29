
doctored_test_results<-function(desc,code,scribe){

  results<-scribe$return_results()
  names(results)<-c("Expectation","Result")
  results$Result<-gsub("\\n.*$","",results$Result)

  cat(paste("###",desc,"\n\n"))
  cat("```\n")
  cat(paste(code[-1],collapse = "\n"),"\n")
  cat("```\n")
  cat(paste(knitr::kable(results, format = "markdown",row.names=FALSE),collapse = "\n"),"\n")
  cat("\n\n")
}
