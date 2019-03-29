
#' object for managing the recording of tests and their results
#''
#' @keywords internal
#' @export
#' @importFrom R6 R6Class
#' @importFrom tibble tibble add_row
test_scribe<- R6::R6Class("Test_Scribe",
                          public = list(
                            results = tibble(expectation = character(),
                                             result      = character(),
                                             type        = character()),
                            result_list = list(),
                            initialize = function() {
                              self$results<-tibble(expectation = character(),
                                                   result      = character(),
                                                   type        = character())
                              self$result_list<-list()
                            },
                            add_result = function(result,type){

                              self$result_list<-c(self$result_list,list(result))

                              if(type=="error"){
                                expectation<-as.character(result$call[[1]][[3]])
                                result_message<-"Error"

                              }else{
                                expectation<-as.character(result$call)
                                result_message<-result$message

                              }
                              self$results<-add_row(self$results,
                                                    expectation=expectation,
                                                    result=result_message,
                                                    type=type)
                            },

                            print_results = function(){
                              results_output<-self$return_results()
                              print(data.frame(results_output))
                            },

                            return_results = function(){
                              self$results
                            },
                            add_warning = function(result){
                              self$result_list<-c(self$result_list,result)
                              expectation<-as.character(result$call)
                              result_message<-result$message
                              self$results<-add_row(self$results,
                                                    expectation=expectation,
                                                    result=result_message)
                            }


                            ))
