#' Druid
#' 
#' A soft wrapper around [log::Logger] to easily
#' log messages for ambiorix applications.
#' 
#' @export 
Druid <- R6::R6Class(
  "Druid",
  inherit = log::Logger,
  public = list(
    #' @details Constructor
    #' @param prefix Prefix of the log messages.
    #' @param http_accept,http_accept_encoding,http_accept_language,http_cache_control,http_connection,http_cookie,http_host,http_sec_fetch_dest,http_sec_fetch_mode,http_sec_fetch_site,http_sec_fetch_user,http_upgrade_insecure_requests,http_user_agent,path_info,query_string,remote_addr,remote_port,request_method,script_name,server_name,server_port,content_length,content_type,http_referer Whether to log these headers.
    initialize = function(
      prefix = ">",
      http_accept = FALSE,
      http_accept_encoding = FALSE,
      http_accept_language = FALSE,
      http_cache_control = FALSE,
      http_connection = FALSE,
      http_cookie = FALSE,
      http_host = FALSE,
      http_sec_fetch_dest = FALSE,
      http_sec_fetch_mode = FALSE,
      http_sec_fetch_site = FALSE,
      http_sec_fetch_user = FALSE,
      http_upgrade_insecure_requests = FALSE,
      http_user_agent = FALSE,
      path_info = FALSE,
      query_string = FALSE,
      remote_addr = FALSE,
      remote_port = FALSE,
      request_method = FALSE,
      script_name = FALSE,
      server_name = FALSE,
      server_port = FALSE,
      content_length = FALSE,
      content_type = FALSE,
      http_referer = FALSE
    ) {
      args <- as.list(environment())[-1L]
      args <- args[sapply(args, \(x) x)]
      if(length(args) == 0L)
        stop("Nothing set to log")
        
      super$initialize(prefix)

      private$.elements <- args |> 
        names() |> 
        toupper()

      self$printer <- cli::cli_text

      self$
        date()$
        time()

      invisible(self)
    },
    #' @details Split every item on its own log line
    split = function() {
      private$.combined <- FALSE
      invisible(self)
    },
    #' @details Log from request
    #' @param req A request, see [ambiorix::Request].
    log = function(req) {

      if(private$.combined){
        str <- sapply(private$.elements, \(el) {
          sprintf(
            "%s: {.val %s}",
            el,
            req[[el]]
          )
        })
        super$log(str)
        return(invisible(self))
      }

      sapply(private$.elements, \(el) {
        str <- sprintf(
          "%s: {.val %s}",
          el,
          req[[el]]
        )
        super$log(str)
      })

      invisible(self)
    }
  ),
  private = list(
    .combined = TRUE,
    .elements = c()
  )
)
