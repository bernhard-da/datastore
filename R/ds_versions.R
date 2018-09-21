#' ds_versions
#'
#' returns a data.frame (or \code{NULL}) containing information on all versions of the requested data-object given by argument \code{name}
#'
#' @param ds path to datastore
#' @param name name of data-object
#' @param verbose (logical) if TRUE, additional messages will be printed to prompt
#'
#' @return a \code{data.frame} or \code{NULL}
#' @export
#'
#' @examples
#' ## not yet
ds_versions <- function(ds, name, verbose=TRUE) {
  ds_isvalid(ds)
  stopifnot(is_scalar_logical(verbose))

  res <- ds_read_index(ds)
  if (!is.data.frame(res$info)) {
    if (verbose) {
      message(paste("no files in datastore",shQuote(ds_info(ds, verbose=FALSE)$ds_name),"--> please use ds_add()"))
    }
    return(invisible(NULL))
  }
  if (!name %in% res$datasets) {
    if (verbose) {
      message(paste(shQuote(name),"not in datastore",shQuote(ds_info(ds, verbose=FALSE)$ds_name)))
    }
    return(invisible(NULL))
  }

  info <- res$info
  info$version <- as.numeric(info$version)
  info[name==name,,drop=F]
}
