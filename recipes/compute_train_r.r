library(dataiku)
library(dplyr)

# Recipe inputs
churn_prepared_r <- dkuReadDataset("churn_prepared_r", samplingMethod="head", nbRows=100000)

# Data preparation
churn_prepared_r %>%
    rowwise() %>%
    mutate(splitter = runif(1)) %>%
    ungroup() ->
    df_to_split

# Compute recipe outputs
train_r <- subset(df_to_split, df_to_split$splitter <= 0.7)
test_r <- subset(df_to_split, df_to_split$splitter > 0.7)

# Recipe outputs
dkuWriteDataset(train_r,"train_r")
dkuWriteDataset(test_r,"test_r")
