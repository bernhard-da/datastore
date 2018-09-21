#' ds_get_latest
#'
#' retrieves the latest version of a given dataset from a datastore
#'
#' @param ds path to datastore
#' @param ds_name name of data-object to retrieve
#'
#' @return the requested data-object
#' @export
#'
#' @examples
#' ## not yet
ds_get_latest <- function(ds, ds_name) {
  ds_isvalid(ds)

  res <- ds_versions(ds, ds_name=ds_name)
  if (nrow(res)==0) {
    stop(paste("Dataset",shQuote(substitute(ds_name)),"not found in datastore"), call.=FALSE)
  }

  fin <- res[res$version==max(res$version),"filepath"]
  stopifnot(length(fin)==1)
  return(readRDS(file=fin))
}