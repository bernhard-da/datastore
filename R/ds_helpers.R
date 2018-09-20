## helpers
ds_isvalid <- function(ds) {
  stopifnot(is_scalar_character(ds))
  finfo <- file.path(ds, "datastore","DATASTORE_INFO")
  stopifnot(file.exists(finfo))
  res <- fromJSON(finfo)
  stopifnot(is.list(res), length(res)==3, names(res)==c("ds_name","created_at","datastore_path"))
  return(invisible(TRUE))
}

ds_infofile <- function(ds) {
  file.path(ds, "datastore", "DATASTORE_INFO")
}
ds_datasetfile <- function(ds) {
  ds_isvalid(ds)
  file.path(ds, "datastore", "DATASETS")
}

ds_filepath <- function(ds) {
  file.path(ds, "datastore", "files")
}

ds_timestamp <- function() {
  format(Sys.time(), "%Y%m%d_%H%M")
}
