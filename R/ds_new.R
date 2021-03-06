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
#' @param ds path to datastore
#' @export
#' @examples
#' \dontrun{
#' ## create a datastore
#' ds <- "/tmp/mydatastore"
#' unlink(ds, recursive = TRUE)
#'
#' ## create datastore
#' ds_new(ds)
#' list.files(ds, recursive=TRUE)
#' ds_info(ds)
#'
#' ## testdata
#' df_v1 <- data.frame(x=1, y=1)
#' df_v2 <- data.frame(x=2, y=2)
#' df_v3 <- data.frame(x=3, y=3)
#'
#' ## add them to the datastore
#' ## same name, different versions
#' ds_add(ds, obj=df_v1, ds_name="df", version=1)
#' ds_add(ds, obj=df_v2, ds_name="df", version=2)
#' ds_add(ds, obj=df_v3, ds_name="df", version=3)
#'
#' ## read general information about datastore(s)
#' ds_read_index(ds)
#'
#' ## check if dataset is available in datastore
#' ds_exists(ds, ds_name="df2") # --> FALSE
#' ds_exists(ds, ds_name="df")  # --> TRUE
#'
#' ## get information about datasets
#' ds_versions(ds, ds_name="df")
#'
#' ## retrieve versioned datasets from datastore
#' v1 <- ds_get(ds, ds_name="df", version=1); identical(v1, df_v1)
#' v2 <- ds_get(ds, ds_name="df", version=2); identical(v2, df_v2)
#' v3 <- ds_get(ds, ds_name="df", version=3); identical(v3, df_v3)
#'
#' ## get latest version
#' ds_get_latest(ds, ds_name="df")
#'
#' ## remove from datastore
#' ds_remove(ds, ds_name="df2", version=NULL) # error
#' ds_remove(ds, ds_name="df", version=1) # remove a specific version
#' ds_remove(ds, ds_name="df", version=NULL) # remove all versions
#' }
ds_new <- function(ds) {
  stopifnot(is_scalar_character(ds))

  if (file.exists(ds)) {
    stop("Directory at", shQuote(ds), "already exists")
  }
  res <- suppressWarnings(dir.create(ds))
  if (!res) {
    stop("datastore could not be initialized, invalid path or problem with permissions?")
  }
  dir.create(file.path(ds, "datastore"))
  dir.create(file.path(ds, "datastore", "files"))

  ds_update_index(ds)
  message(paste("Datastore at", shQuote(file.path(ds)), "successfully initialized."))
  return(invisible(ds))
}
