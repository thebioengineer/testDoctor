
#' object for managing the recording of tests and their results
#''
#' @keywords internal
#' @export
#' @importFrom R6 R6Class
#' @importFrom tibble tibble add_row
test_scribe<- R6::R6Class("Test_Scribe",
                          public = list(
                            results = tibble(expectation=character(),
                                             result= character()),
                            latest_result = NULL,
                            initialize = function() {
                              self$results<-tibble(expectation=character(),
                                                   result= character())
                            },
                            add_result = function(result){
                              self$latest_result<-result
                              expectation<-as.character(result$call)
                              result_message<-result$message
                              self$results<-add_row(self$results,
                                                    expectation=expectation,
                                                    result=result_message)
                            },

                            print_results = function(){
                              results_output<-self$return_results()
                              print(data.frame(results_output))
                            },

                            return_results = function(){
                              self$results
                            }
                            ))
