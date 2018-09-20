ds_info <- function(path) {
  ds_isvalid(path)
  res <- fromJSON(ds_infofile(path))
  info <- fromJSON(ds_datasetfile(path))
  if (is.na(info$datasets)) {
    res$nr_datasets <- 0
    res$nr_files <- 0
  } else {
    res$nr_datasets <- length(unique(info$datasets$name))
    res$nr_files <- nrow(info$datasets$name)
  }
  res
}
