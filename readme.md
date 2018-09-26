## datastore pkg

This is the datastore package that allows to save versioned datasets in R inspired by the miniCRAN pkg.

## Updates
### v0.3.1
- recreate DATASTORE file in case files have been (manually) deleted
### v0.3.0
- initial version

## Useage
```
library(datastore)
ds <- "/tmp/mydatastore"
unlink(ds, recursive=TRUE)
ds_new(ds)

df1 <- data.frame(x=1)
df2 <- data.frame(x=1, y=2)
df3 <- data.frame(x=1, y=2, z=3)

# add a dataset to the datastore
ds_add(ds, obj=df1, ds_name="dataset1", version=1)
ds_add(ds, obj=df2, ds_name="dataset1", version=2)
ds_add(ds, obj=df3, ds_name="dataset1", version=3)

# information about current state
ds_info(ds)

ds_exists(ds, ds_name="dataset2", version=1)
ds_exists(ds, ds_name="dataset1", version=1)

# show versions
ds_versions(ds, ds_name="dataset1")
ds_versions(ds, ds_name="dataset2")

# get specific version
ds_get(ds, ds_name="dataset1", version=1)
# get latest version
ds_get_latest(ds, ds_name="dataset1")

# remove a specific version
ds_remove(ds, ds_name="dataset1", version=2)

# remove all versions
ds_remove(ds, ds_name="dataset1")
```