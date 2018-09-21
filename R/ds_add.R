#' ds_add
#'
#' add a dataset to a datastore
#'
#' @param ds path to datastore
#' @param obj the R-data object that should be put into the datastore
#' @param ds_name name of data-object
#' @param version (number) version of data-object
#'
#' @return \code{TRUE} if the data-object was successfully added to the datastore
#' @export
#'
#' @examples
#' ## not yet
ds_add <- function(ds, obj, ds_name, version) {
  ds_isvalid(ds)
  stopifnot(is_scalar_character(ds_name))
  stopifnot(is_scalar_integerish(version))

  # version already exists?
  if (ds_exists(ds, ds_name=ds_name, version=version, verbose=FALSE)) {
    stop(paste("object", substitute(ds_name),"in version",version, "already exists in datastore."))
  }

  fout <- file.path(ds_filepath(ds), paste0(ds_name, "_-__-_",version,"_-__-_",ds_timestamp(),".rds"))
  saveRDS(obj, file=fout, compress=TRUE)

  ds_update_index(ds, verbose=FALSE)
  message(paste("File", substitute(obj),"in version",version, "added to datastore"))
  return(invisible(TRUE))
}