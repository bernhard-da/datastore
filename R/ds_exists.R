#' ds_exists
#'
#' @param ds path to datastore
#' @param name name of data-object
#' @param version specific version of data-object to query; if \code{NULL}, it is checked if the object is versioned at least one time.
#' @param verbose (logical) if \code{TRUE}, additional messages will be printed to prompt
#' @return \code{TRUE} if the data-object is available from the datastore given by argument \code{ds} or \code{FALSE} else.
#' @export
#'
#' @examples
#' ## not yet
ds_exists <- function(ds, name, version=NULL, verbose=TRUE) {
  ds_isvalid(ds)

  if (!is.null(version)) {
    stopifnot(is_scalar_integerish(version))
  }

  res <- ds_versions(ds, name=name, verbose=verbose)
  if (is.null(res)) {
    return(FALSE)
  }
  if (is.null(version)) {
    if (nrow(res)>0) {
      return(TRUE)
    } else {
      return(FALSE)
    }
  }

  res <- res[res$version==version,]
  return(ifelse(nrow(res)>0, TRUE, FALSE))
}