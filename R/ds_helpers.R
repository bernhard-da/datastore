## helpers
ds_isvalid <- function(ds) {
  stopifnot(is_scalar_character(ds))
  finfo <- ds_infofile(ds)
  if (file.exists(finfo)) {
    res <- fromJSON(finfo)
    stopifnot(is.list(res), length(res)==6, names(res)==c("ds_name","created_at","datastore_path","last_indexed","datasets","info"))
  }
  return(invisible(TRUE))
}

ds_infofile <- function(ds) {
  file.path(ds, "datastore", "DATASTORE")
}

ds_filepath <- function(ds) {
  file.path(ds, "datastore", "files")
}

ds_timestamp <- function() {
  format(Sys.time(), "%Y%m%d_%H%M")
}
