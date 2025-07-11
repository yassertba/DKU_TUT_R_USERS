library(dataiku)
library(gbm)
library(caret)

# Load R model (local or non-local folder)
data <- dkuManagedFolderDownloadPath("model_r", "model.RData")
load(rawConnection(data))

# Load R model (local folder only)
# model_r <- dkuManagedFolderPath("model_r")
# path <- paste(model_r, 'model.RData', sep="/")
# load(path)

# Confirm model loaded
print(gbm.fit)

# Recipe inputs
df <- dkuReadDataset("test_r")

# Call project variables
vars <- dkuGetProjectVariables()
target.variable <- vars$standard$target_var
features.cat <- unlist(vars$standard$categoric_vars)
features.num <- unlist(vars$standard$numeric_vars)

# Preprocessing
df[features.cat]    <- lapply(df[features.cat], as.factor)
df[features.num]    <- lapply(df[features.num], as.double)
df[target.variable] <- lapply(df[target.variable], as.factor)
test.ml <- df[c(features.cat, features.num, target.variable)]

# Prediction
o <- cbind(df, predict(gbm.fit, test.ml,
                    type = "prob",
                    na.action = na.pass))

# Recipe outputs
dkuWriteDataset(o, "test_scored_r")