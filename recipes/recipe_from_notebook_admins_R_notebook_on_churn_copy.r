# -------------------------------------------------------------------------------- NOTEBOOK-CELL: CODE
library(dataiku)
library(dplyr)

# -------------------------------------------------------------------------------- NOTEBOOK-CELL: CODE
# Read the dataset as a R dataframe in memory
# Note: here, we only read the first 100K rows. Other sampling options are available
df <- dkuReadDataset("churn_copy", samplingMethod="head", nbRows=100000)

# -------------------------------------------------------------------------------- NOTEBOOK-CELL: CODE
df %>%
    rename(Churn = Churn.) %>%
    mutate(Churn = if_else(Churn == "True.", "True", "False"),
        Area_Code = as.character(Area_Code)) %>%
    select(-Phone) ->
    df_prepared_r

# -------------------------------------------------------------------------------- NOTEBOOK-CELL: CODE
# Recipe outputs
dkuWriteDataset(df_prepared_r,"churn_prepared_r")