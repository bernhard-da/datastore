#' ds_info
#'
#' @param path path to datastore
#'
#' @return a list with the following elements
#' \itemize{
#' \item \strong{name}: name of the datastore
#' \item \strong{created_at}: timestamp when the datastare has been created
#' \item \strong{datastore_path}: path to the root of the datastore
#' \item \strong{datasets}: names of data objects for which at least one version is stored in the datastore\code{NA}
#' \item \strong{nr_datasets}: number of different data objects available from the datastore
#' \item \strong{nr_files}: number of datafiles stored
#' }
#' @export
#'
#' @examples
#' ## not yet
ds_info <- function(path) {
  print.datastore <- function(x, ...) {
    message(paste("The datastore",shQuote(x$name),"was created at",shQuote(x$created_at)))
    message(paste("The root is located at", shQuote(x$datastore_path)))

  }
  ds_isvalid(path)
  res <- fromJSON(ds_infofile(path))
  datafiles <- fromJSON(ds_datasetfile(path))
  if (!is.data.frame(datafiles$info)) {
    res$datasets <- NA
    res$nr_datasets <- 0
    res$nr_files <- 0
  } else {
    res$datasets <- datafiles$datasets
    res$nr_datasets <- length(res$datasets)
    res$nr_files <- nrow(datafiles$info)
  }
  class(res) <- "datastore"
  print(res)
  invisible(res)
}
