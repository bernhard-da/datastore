#' ds_dataset_remove
#'
#' @param path path to datastore
#' @param name name of data-object for which a specific version should be removed
#' @param version (number) version of data-object; if \code{NULL}, all versions will be removed
#'
#' @return \code{NULL}
#' @export
#'
#' @examples
#' ## not yet
ds_dataset_remove <- function(path, name, version=NULL) {
  ds_isvalid(path)

  stopifnot(is_scalar_character(name))

  if (!is.null(version)) {
    stopifnot(is_scalar_integerish(version))
  }
  res <- ds_dataset_exists(path, name=name, version=version, verbose=FALSE)
  if (!res) {
    stop(paste("dataset", shQuote(substitute(name)),"does not exist in datastore or required version is not available"))
  }

  df <- ds_read_index(path)$info
  df <- df[df$name==name,,drop=F]
  if (!is.null(version)) {
    df <- df[df$version==version,,drop=F]
  }

  files_to_del <- df$filepath
  res <- file.remove(files_to_del)
  if (!all(res)) {
    stop("some files could not be deleted from datastore")
  }
  message(paste(length(files_to_del),"file(s) successfully deleted from datastore"))
  ds_update_index(path, verbose=FALSE)
  return(invisible(NULL))
}