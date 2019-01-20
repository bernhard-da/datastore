set.seed(1)
ds <- tempdir()
unlink(ds, recursive=TRUE)
ds_new(ds)

df1 <- data.frame(x=1)
df2 <- data.frame(x=1, y=2)
df3 <- list(x=1, y=2, z=3)

# add a dataset to the datastore
ds_add(ds, obj=df1, ds_name="dataset1", version=1)
ds_add(ds, obj=df2, ds_name="dataset1", version=2)
ds_add(ds, obj=df3, ds_name="dataset1", version=3)

context("adding data to the datastore")

r <- datastore:::ds_info(ds)
expect_equal(r$datasets, "dataset1")
expect_is(r$info, "data.frame")
expect_equal(nrow(r$info), 3)
expect_equal(ncol(r$info), 5)
expect_identical(r$nr_datasets, 1L)
expect_identical(r$nr_files, 3L)
