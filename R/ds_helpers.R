## helpers
ds_isvalid <- function(path) {
  stopifnot(is_scalar_character(path))
  finfo <- file.path(path, "datastore","DATASTORE_INFO")
  stopifnot(file.exists(finfo))
  res <- fromJSON(finfo)
  stopifnot(is.list(res), length(res)==3, names(res)==c("name","created_at","datastore_path"))
  return(invisible(TRUE))
}

ds_infofile <- function(path) {
  file.path(path, "datastore", "DATASTORE_INFO")
}
ds_datasetfile <- function(path) {
  ds_isvalid(path)
  file.path(path, "datastore", "DATASETS")
}

ds_filepath <- function(path) {
  file.path(path, "datastore", "files")
}

ds_timestamp <- function() {
  format(Sys.time(), "%Y%m%d_%H%M")
}
