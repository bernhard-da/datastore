#' ds_dataset_versions
#'
#' returns a data.frame (or \code{NULL}) containing information on all versions of the requested data-object given by argument \code{name}
#'
#' @param path path to datastore
#' @param name name of data-object
#' @param verbose (logical) if TRUE, additional messages will be printed to prompt
#'
#' @return a \code{data.frame} or \code{NULL}
#' @export
#'
#' @examples
#' ## not yet
ds_dataset_versions <- function(path, name, verbose=TRUE) {
  ds_isvalid(path)
  stopifnot(is_scalar_logical(verbose))

  res <- ds_read_index(path)
  if (!is.data.frame(res$info)) {
    if (verbose) {
      message(paste0("no files in datastore -> please use ds_dataset_add()"))
    }
    return(invisible(NULL))
  }
  if (!name %in% res$datasets) {
    if (verbose) {
      message(paste(shQuote(name),"not in datastore"))
    }
    return(invisible(NULL))
  }

  info <- res$info
  info$version <- as.numeric(info$version)
  info[name==name,,drop=F]
}
