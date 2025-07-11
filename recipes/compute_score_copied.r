library(dataiku)

# Recipe inputs
test_scored <- dkuReadDataset("test_scored", samplingMethod="head", nbRows=100000)

# Compute recipe outputs from inputs
# TODO: Replace this part by your actual code that computes the output, as a R dataframe or data table
score_copied <- test_scored # For this sample code, simply copy input to output


# Recipe outputs
dkuWriteDataset(score_copied,"score_copied")
