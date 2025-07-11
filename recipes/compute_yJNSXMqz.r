library(dataiku)
library(gbm)
library(caret)

# Import from project library
dkuSourceLibR("train_settings.R")

# Recipe inputs
df <- dkuReadDataset("train_r")

# Call project variables
vars <- dkuGetProjectVariables()
target.variable <- vars$standard$target_var
features.cat <- unlist(vars$standard$categoric_vars)
features.num <- unlist(vars$standard$numeric_vars)

# Preprocessing
df[features.cat]    <- lapply(df[features.cat], as.factor)
df[features.num]    <- lapply(df[features.num], as.double)
df[target.variable] <- lapply(df[target.variable], as.factor)
train.ml <- df[c(features.cat, features.num, target.variable)]

# Training (fit.control and gbm.grid found in train_settings.R)
gbm.fit <- train(
    Churn ~ .,
    data = train.ml,
    method = "gbm",
    trControl = fit.control,
    tuneGrid = gbm.grid,
    metric = "ROC",
    verbose = FALSE
)

# Recipe outputs
# Recipe outputs (local or non-local folder)
save(gbm.fit, file= "model.RData")
connection <- file("model.RData", "rb")
dkuManagedFolderUploadPath("model_r", "model.RData", connection)
close(connection)