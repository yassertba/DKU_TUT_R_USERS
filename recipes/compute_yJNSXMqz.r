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
model_r <- dkuManagedFolderPath("model_r")
setwd(model_r)
system("rm -rf *")
path <- paste(model_r, 'model.RData', sep="/")
save(gbm.fit, file = path)