#' ds_dataset_remove
#'
#' @param ds path to datastore
#' @param name name of data-object for which a specific version should be removed
#' @param version (number) version of data-object; if \code{NULL}, all versions will be removed
#' @param verbose (logical) if \code{TRUE}, additional messages will be printed to prompt
#' @return \code{NULL}
#' @export
#'
#' @examples
#' ## not yet
ds_dataset_remove <- function(ds, name, version=NULL, verbose=TRUE) {
  ds_isvalid(ds)

  stopifnot(is_scalar_character(name), is_scalar_logical(verbose))

  if (!is.null(version)) {
    stopifnot(is_scalar_integerish(version))
  }
  res <- ds_dataset_exists(ds, name=name, version=version, verbose=FALSE)
  if (!res) {
    stop(paste("dataset", shQuote(substitute(name)),"does not exist in datastore",shQuote(ds_info(ds, verbose=FALSE)$ds_name),"or required version is not available"), call.=FALSE)
  }

  df <- ds_read_index(ds)$info
  df <- df[df$name==name,,drop=F]
  if (!is.null(version)) {
    df <- df[df$version==version,,drop=F]
  }

  files_to_del <- df$filepath
  res <- file.remove(files_to_del)
  if (!all(res)) {
    stop("some files could not be deleted from datastore")
  }
  if (verbose) {
    message(paste(length(files_to_del),"file(s) successfully deleted from datastore",shQuote(ds_info(ds, verbose=FALSE)$ds_name)))
  }
  ds_update_index(ds, verbose=FALSE)
  return(invisible(NULL))
}