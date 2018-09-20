#' ds_dataset_get
#'
#' retrieves a given dataset in a specific version from a datastore
#'
#' @param path path to datastore
#' @param name name of data-object to retrieve
#' @param version versionnumber of data-object to retrieve
#'
#' @return the requested data-object
#' @export
#'
#' @examples
#' ## not yet
ds_dataset_get <- function(path, name, version) {
  ds_isvalid(path)
  stopifnot(is_scalar_integerish(version))

  res <- ds_dataset_versions(path, name=name)
  if (nrow(res)==0) {
    stop(paste("Dataset",shQuote(substitute(name)),"not found in datastore"), call.=FALSE)
  }

  if (!version %in% res$version) {
    stop(paste("Dataset",shQuote(substitute(name)),"not found in version",version,"in datastore"), call.=FALSE)
  }

  fin <- res[res$version==version,"filepath"]
  print(fin)
  stopifnot(length(fin)==1)
  return(readRDS(file=fin))
}