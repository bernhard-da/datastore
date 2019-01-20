library(testthat)
library(datastore)

context("creating a adatastore")

ds <- tempdir()
unlink(ds, recursive=TRUE)
ds_new(ds)

r <- datastore:::ds_info(ds)
expect_s3_class(r, "datastore")
expect_identical(r$datasets, NA)
expect_identical(r$info, NA)
expect_identical(r$nr_datasets, 0)
expect_identical(r$nr_files, 0)


ds <- tempdir()
unlink(ds, recursive=TRUE)
ds_new(ds)

context("adding elements")

df1 <- data.frame(x=1)
df2 <- data.frame(x=1, y=2)
df3 <- list(x=1, y=2, z=3)

# add a dataset to the datastore
ds_add(ds, obj=df1, ds_name="dataset1", version=1)
ds_add(ds, obj=df2, ds_name="dataset1", version=2)
ds_add(ds, obj=df3, ds_name="dataset1", version=3)

r <- datastore:::ds_info(ds)
expect_equal(r$datasets, "dataset1")
expect_is(r$info, "data.frame")
expect_equal(nrow(r$info), 3)
expect_equal(ncol(r$info), 5)
expect_identical(r$nr_datasets, 1L)
expect_identical(r$nr_files, 3L)

context("removing datasets")
ds_remove(ds, ds_name="dataset1", version=1)

vers <- ds_versions(ds, ds_name = "dataset1")
expect_is(vers, "data.frame")
expect_identical(vers$version, c(2,3))

expect_error(ds_get(ds, ds_name = "dataset1", version = 1), "Dataset 'dataset1' not found in version 1 in datastore")

expect_equal(ds_exists(ds, ds_name = "dataset1"), TRUE)
expect_equal(ds_exists(ds, ds_name = "dataset1", version = 1), FALSE)
expect_equal(ds_exists(ds, ds_name = "dataset1", version = 2), TRUE)
expect_equal(ds_exists(ds, ds_name = "dataset1", version = 3), TRUE)

r <- datastore:::ds_info(ds)
expect_equal(r$datasets, "dataset1")
expect_is(r$info, "data.frame")
expect_equal(nrow(r$info), 2)
expect_equal(ncol(r$info), 5)
expect_identical(r$nr_datasets, 1L)
expect_identical(r$nr_files, 2L)
