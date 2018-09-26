#' ds_update_index
#'
#' updates index file (json-format) of a given datastore
#'
#' @param ds path to datastore
#' @param verbose (logical) if \code{TRUE}, additional messages will be printed to prompt
#' @return \code{NULL}
#' @export
#'
#' @examples
#' ## not yet
ds_update_index <- function(ds, verbose=TRUE) {
  out <- list()

  if (file.exists(ds_infofile(ds))) {
    oldres <- ds_read_index(ds)
    out$ds_name <- oldres$ds_name
    out$created_at <- oldres$created_at
    out$datastore_path <- oldres$datastore_path
  } else {
    out$ds_name <- "datastore"
    out$created_at <- ds_timestamp()
    out$datastore_path <- ds
  }

  files <- list.files(ds_filepath(ds))
  out$last_indexed <- ds_timestamp()
  if (length(files)>0) {
    files_o <- list.files(ds_filepath(ds), full.names=TRUE)

    files <- sub("[.]rds", "", files)
    files <- strsplit(files, "_-__-_")
    df <- data.frame(do.call("rbind", files), stringsAsFactors=FALSE)
    colnames(df) <- c("ds_name", "version","timestamp")
    df$filepath <- files_o
    df$sha512 <- sapply(files_o, function(x) { digest(x, algo="sha512")})
    df <- df[order(df$ds_name, df$version),]

    out$datasets <- unique(df$ds_name)
    out$info <- df
  } else {
    out$datasets <- NA
    out$info <- NA
  }

  cat(toJSON(out), file=ds_infofile(ds))
  if (verbose) {
    message(paste("DATASTORE file successfully updated!"))
  }
  return(invisible(NULL))
}