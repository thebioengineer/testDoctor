#' Source a file and document tests performed
#'
#' @param path Path to tests
#' @param env Environment in which to evaluate code.
#' @param chdir Change working directory to `dirname(path)`?
#' @param encoding Deprecated
#' @param wrap Automatically wrap all code within [test_that()]? This ensures
#'   that all expectations are reported, even if outside a test block.
#' @export
#' @keywords internal
doc_source_file <- function(path, env = test_env(), chdir = TRUE,
                        encoding = "UTF-8", wrap = TRUE) {

  stopifnot(file.exists(path))
  stopifnot(is.environment(env))

  if (!missing(encoding) && !identical(encoding, "UTF-8")) {
    warning("`encoding` is deprecated; all files now assumed to be UTF-8", call. = FALSE)
  }


  exprs <- doctoredExpression(path)

  n <- length(exprs)
  if (n == 0L) return(invisible())

  if (chdir) {
    old_dir <- setwd(dirname(path))
    on.exit(setwd(old_dir), add = TRUE)
  }



  invisible(eval(exprs,env = env))

}

doctoredExpression<-function(path){
  lines <- readr::read_lines(path)
  srcfile <- srcfilecopy(path, lines, file.info(path)[1, "mtime"], isFile = TRUE)

  #replace context with doctored_context
  if(any(grepl("context",lines))){
    lines[grepl("context",lines)]<-gsub("context","testDoctor:::doctored_context", lines[grepl("context",lines)])
  }

  if(any(grepl("test_that",lines))){
    lines[grepl("test_that",lines)]<-gsub("test_that","testDoctor:::doctored_test_that",lines[grepl("test_that",lines)])
  }

 parse(
    textConnection(lines, encoding = "UTF-8"),
    n = -1, encoding = "UTF-8")
}
