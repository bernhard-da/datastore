#' ds_read_index
#'
#' reads (json)-index file about all versioned data-objects from specified datastore
#'
#' @param path path to datastore
#'
#' @return a list containing the following elements
#' \itemize{
#' \item \strong{last_indexed}: timestamp
#' \item \strong{datasets}: the name of the datasets that are versioned
#' \item \strong{info}: a \code{data.frame} containing information about all versioned data-objects
#' }
#' @export
#'
#' @examples
#' ## not yet
ds_read_index <- function(path) {
  # read json of dataset files
  return(fromJSON(ds_datasetfile(path)))
}