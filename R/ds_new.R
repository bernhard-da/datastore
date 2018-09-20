#' ds_new
#'
#' This function creates a new local datastore at a specified destination folder
#' and creates the DATASETS index file.
#' @section datastore folder structure:
#' The folder structure of a repository
#' \itemize{
#'  \item{Root}
#'  \itemize{
#'    \item{datasets/files}
#'    \itemize{
#'      \item{DATASETS}
#'    }
#'  }
#' }
#'
#' @param path Destination download path. This path is the root folder of your new repository.
#'
#' @export
#' @examples
#' ## not yet
ds_new <- function(path) {
  stopifnot(is_scalar_character(path))
  if (file.exists(path)) {
    stop("Directory at",shQuote(path),"already exists")
  }
  res <- suppressWarnings(dir.create(path))
  if (!res) {
    stop("datastore could not be initialized, invalid path or problem with permissions?")
  }
  dir.create(file.path(path,"datastore"))
  dir.create(file.path(path,"datastore","files"))

  info <- list()
  info$name <- "DATASTORE"
  info$created_at <- ds_timestamp()
  info$datastore_path <- path

  cat(toJSON(info), file=ds_infofile(path))

  ds_update_index(path)
  message(paste("Datastore at",shQuote(file.path(path)),"successfully initialized."))
  return(invisible(path))
}