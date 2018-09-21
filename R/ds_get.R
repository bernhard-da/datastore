#' ds_get
#'
#' retrieves a given dataset in a specific version from a datastore
#'
#' @param ds path to datastore
#' @param name name of data-object to retrieve
#' @param version versionnumber of data-object to retrieve
#'
#' @return the requested data-object
#' @export
#'
#' @examples
#' ## not yet
ds_get <- function(ds, name, version) {
  ds_isvalid(ds)
  stopifnot(is_scalar_integerish(version))

  res <- ds_versions(ds, name=name)
  if (nrow(res)==0) {
    stop(paste("Dataset",shQuote(substitute(name)),"not found in datastore", shQuote(ds_info(ds, verbose=FALSE)$ds_name)), call.=FALSE)
  }

  if (!version %in% res$version) {
    stop(paste("Dataset",shQuote(substitute(name)),"not found in version",version,"in datastore",shQuote(ds_info(ds, verbose=FALSE)$ds_name)), call.=FALSE)
  }

  fin <- res[res$version==version,"filepath"]
  stopifnot(length(fin)==1)
  return(readRDS(file=fin))
}