#' ds_get
#'
#' retrieves a given dataset in a specific version from a datastore
#'
#' @param ds path to datastore
#' @param ds_name name of data-object to retrieve
#' @param version versionnumber of data-object to retrieve
#'
#' @return the requested data-object
#' @export
#'
#' @examples
#' ## not yet
ds_get <- function(ds, ds_name, version) {
  ds_isvalid(ds)
  stopifnot(is_scalar_integerish(version))

  res <- ds_versions(ds, ds_name = ds_name)
  if (nrow(res) == 0) {
    stop(paste("Dataset", shQuote(substitute(ds_name)), "not found in datastore"), call. = FALSE)
  }

  if (!version %in% res$version) {
    stop(paste("Dataset", shQuote(substitute(ds_name)), "not found in version", version, "in datastore"), call. = FALSE)
  }

  fin <- res[res$version == version, "filepath"]
  stopifnot(length(fin) == 1)
  return(readRDS(file = fin))
}
