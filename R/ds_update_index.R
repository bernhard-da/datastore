#' ds_update_index
#'
#' updates index file (json-format) of a given datastore
#'
#' @param path path to datastore
#' @param verbose (logical) if \code{TRUE}, additional messages will be printed to prompt
#' @return \code{NULL}
#' @export
#'
#' @examples
#' ## not yet
ds_update_index <- function(path, verbose=TRUE) {
  ds_isvalid(path)

  files <- list.files(ds_filepath(path))
  out <- list()
  out$last_indexed <- ds_timestamp()
  if (length(files)>0) {
    files_o <- list.files(ds_filepath(path), full.names=TRUE)

    files <- sub("[.]rds", "", files)
    files <- strsplit(files, "_-__-_")
    df <- data.frame(do.call("rbind", files), stringsAsFactors=FALSE)
    colnames(df) <- c("name", "version","timestamp")
    df$filepath <- files_o
    df$sha512 <- sapply(files_o, function(x) { digest(x, algo="sha512")})
    df <- df[order(df$name, df$version),]

    out$datasets <- unique(df$name)
    out$info <- df
  } else {
    out$datasets <- NA
    out$info <- NA
  }

  cat(toJSON(out), file=ds_datasetfile(path))
  if (verbose) {
    message(paste("DATASETS file successfully updated!"))
  }
  # write json of dataset files
  return(invisible(NULL))
}