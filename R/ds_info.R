#' ds_info
#'
#' @param ds path to datastore
#' @param verbose (logical) if \code{TRUE}, additional messages will be printed to prompt
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
ds_info <- function(ds, verbose=TRUE) {
  print.datastore <- function(x, ...) {
    message(paste("The datastore",shQuote(x$ds_name),"was created at",shQuote(x$created_at)))
    message(paste("The root is located at", shQuote(x$datastore_path)))

    if (x$nr_datasets>0) {
      message(paste("This datastore contains", x$nr_files,"files of",x$nr_datasets,"datasets"))
    } else {
      message(paste("This datastore is currently empty"))
    }
  }
  ds_isvalid(ds)
  res <- fromJSON(ds_infofile(ds))
  datafiles <- fromJSON(ds_datasetfile(ds))
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
  if (verbose) {
    print(res)
    return(invisible(res))
  }
  return(res)
}
