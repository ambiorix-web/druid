#' Middleware
#' 
#' Druid logger for ambiorix applications.
#' 
#' @param ... Arguments passed to [Druid].
#' 
#' @name middleware
#' 
#' @export 
druid <- \(...) {
  d <- Druid$new(...)
  \(req, res) {
    d$log(req)
    return(NULL)
  }
}