#' ds_dataset_add
#'
#' add a dataset to a datastore
#'
#' @param path path to datastore
#' @param dataset the R-data object that should be put into the datastore
#' @param name name of data-object
#' @param version (number) version of data-object
#'
#' @return \code{TRUE} if the data-object was successfully added to the datastore
#' @export
#'
#' @examples
#' ## not yet
ds_dataset_add <- function(path, dataset, name, version) {
  ds_isvalid(path)
  stopifnot(is_scalar_character(name))
  stopifnot(is_scalar_integerish(version))

  # version already exists?
  if (ds_dataset_exists(path, name=name, version=version, verbose=FALSE)) {
    stop(paste("dataset", substitute(name),"in version",version, "already exists in datastore."))
  }

  fout <- file.path(ds_filepath(path), paste0(name, "_-__-_",version,"_-__-_",ds_timestamp(),".rds"))
  saveRDS(dataset, file=fout, compress=TRUE)

  ds_update_index(path, verbose=FALSE)
  message(paste("File", substitute(dataset),"in version",version, "added to datastore"))
  return(invisible(TRUE))
}