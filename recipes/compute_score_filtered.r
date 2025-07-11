library(dataiku)

# Recipe inputs
test_scored_r <- dkuReadDataset("test_scored_r", samplingMethod="head", nbRows=100000)

# Compute recipe outputs from inputs
# TODO: Replace this part by your actual code that computes the output, as a R dataframe or data table
score_filtered <- test_scored_r # For this sample code, simply copy input to output


# Recipe outputs
dkuWriteDataset(score_filtered,"score_filtered")
