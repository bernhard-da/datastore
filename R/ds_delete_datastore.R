#' ds_delete_datastore
#'
#' deletes a datastore and all files within it
#'
#' @param ds path to datastore
#' @return \code{NULL}
#' @export
#'
#' @examples
#' ## not yet
ds_delete_datastore <- function(ds) {
  ds_isvalid(ds)
  res <- unlink(ds, recursive=TRUE)
  if (res) {
    message("The datastore located at",shQuote(ds),"was deleted!")
  } else {
    warning("The datastore located at",shQuote(ds),"could not be deleted!")
  }
  return(invisible(NULL))
}