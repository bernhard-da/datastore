
R-Package `datastore`
=====================

This is the datastore package that allows to save versioned datasets in R inspired by the miniCRAN pkg.

[![Travis build status](https://travis-ci.org/bernhard-da/datastore.svg?branch=master)](https://travis-ci.org/bernhard-da/datastore) [![Coverage status](https://codecov.io/gh/bernhard-da/datastore/branch/master/graph/badge.svg)](https://codecov.io/github/bernhard-da/datastore?branch=master) [![GitHub last commit](https://img.shields.io/github/last-commit/bernhard-da/datastore.svg?logo=github)](https://github.com/bernhard-da/datastore/commits/master) [![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/bernhard-da/datastore.svg?logo=github)](https://github.com/bernhard-da/datastore)

Useage
------

### Installation

As the package is not yet on cran, it can be installed easily directly from github.

    devtools::install_github("bernhard-da/datastore")

### Load Pkg and create a datastore

    library(datastore)
    ds <- "/tmp/mydatastore"
    unlink(ds, recursive=TRUE)
    ds_new(ds)

### Add datasets to the store

Using `ds_add()` one can add a dataset in different versions to the datastore. Note that the data input is not limited to `data.frames` but can be any R object.

    df1 <- data.frame(x=1)
    df2 <- data.frame(x=1, y=2)
    df3 <- list(x=1, y=2, z=3)

    # add a dataset to the datastore
    ds_add(ds, obj=df1, ds_name="dataset1", version=1)
    ds_add(ds, obj=df2, ds_name="dataset1", version=2)
    ds_add(ds, obj=df3, ds_name="dataset1", version=3)

### Information about current state

this functions shows some generic information about the given datastore

    ds_info(ds)

### Check for existence

Using `ds_exist()` one can check if a dataset in a given version exists in the datastore.

    ds_exists(ds, ds_name="dataset1", version=1)
    ds_exists(ds, ds_name="dataset1", version=5)

### Which versions exist?

Using `ds_versions` one gets an overview over all versions of a stored dataset in the given datastore.

    ds_versions(ds, ds_name="dataset1")

### Fetch data

Using `ds_get()` and `ds_get_latest()` we can fetch specific versions of a dataset from the datastore.

    # specific version
    ds_get(ds, ds_name="dataset1", version=1)
    # latest version
    ds_get_latest(ds, ds_name="dataset1")

### Remove one or all versions of a dataset

Using `ds_remove()` one can remove a single (or all) versions of a dataset from a given datastore.

    # remove a specific version
    ds_remove(ds, ds_name="dataset1", version=2)
    # remove all versions
    ds_remove(ds, ds_name="dataset1")

### Delete the entire datastore

With `ds_delete_datastore()`, one can delete the given datastore and all files versioned within it.
