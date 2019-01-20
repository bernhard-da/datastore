library(testthat)
library(datastore)

ds <- tempdir()
unlink(ds, recursive=TRUE)
ds_new(ds)

r <- datastore:::ds_info(ds)
expect_s3_class(r, "datastore")
expect_identical(r$datasets, NA)
expect_identical(r$info, NA)
expect_identical(r$nr_datasets, 0)
expect_identical(r$nr_files, 0)
