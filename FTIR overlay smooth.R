#The following libraries are required for an FTIR plot
#The function of readxl is to import a .xlsx file into Rstudio - Use this library only if you have your date stored in a .xlsx file. 
#for data in form of a .txt file, upload the data into an excel sheet and then continue with readxl import 
library(readxl)
libafar(readxl)

#ggplot2 is used for plotting the data obtained post processing through signal package
#tidyr package is used in this case for converting more than one line plot data into one single plot
#signal package is used to process the FTIR data - primarily for savitsky golay smoothening - Do read on window size and poly order if mentioned in any research article
library(ggplot2)
library(tidyr)
library(signal)


# Reading the data from the provided file
Test_file <- read_xlsx("file_name.xlsx")

# Converting the data to a data frame and ensuring column names are correct
#Here X represents the Wave number that is to be plotted along the X axis and CM_s represent the Y axis values for 4 FTIR plots
colnames(Test_file) <- c("X", "CM_1", "CM_2", "CM_3", "CM_4")
Test_df <- as.data.frame(Test_file)

# Ensuring X and CM_* columns are numeric
#This step is done to ensure that Rstudio recognizes all values as numbers
Test_df$X <- as.numeric(Test_df$X)
Test_df$CM_1 <- as.numeric(Test_df$CM_1)
Test_df$CM_2 <- as.numeric(Test_df$CM_2)
Test_df$CM_3 <- as.numeric(Test_df$CM_3)
Test_df$CM_4 <- as.numeric(Test_df$CM_4)

# Define window size and polynomial order
#Do follow recommendations given in reference articles but one can always customize this if necessary
#Do note that window size must be an odd number
window_size <- 21
poly_order <- 3

# Apply Savitzky-Golay smoothing
#While there are other types of smoothening methods, majority of research articles follow this
Test_df$CM_smooth_1 <- sgolayfilt(Test_df$CM_1, p = poly_order, n = window_size)
Test_df$CM_smooth_2 <- sgolayfilt(Test_df$CM_2, p = poly_order, n = window_size)
Test_df$CM_smooth_3 <- sgolayfilt(Test_df$CM_3, p = poly_order, n = window_size)
Test_df$CM_smooth_4 <- sgolayfilt(Test_df$CM_4, p = poly_order, n = window_size)

#Converting file names (step no necessary)
Test_df$CM_H1 <- Test_df$CM_smooth_1
Test_df$CM_H2 <- Test_df$CM_smooth_2
Test_df$CM_H3 <- Test_df$CM_smooth_3
Test_df$CM_H4 <- Test_df$CM_smooth_4

# Transform the data into a long format - Combines all four FTIR data into one - Can be done for more
data_long <- pivot_longer(Test_df, cols = starts_with("CM_H"), names_to = "Series", values_to = "Intensity")

# Create the plot
# Create the plot with highlighted areas
ggplot(data_long, aes(x = X, y = Intensity, color = Series)) +
  scale_x_reverse() +
  geom_line() +
  labs(
    title = expression(paste("Consensus of FTIR spectrum for ", italic("C. megacephala"))),
    x = expression("Wave number cm"^-1),
    y = "Transmittance %"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5)  # Center align the title
  ) +
  annotate("rect", xmin = 1350, xmax = 1500, ymin = -Inf, ymax = Inf, alpha = 0.1, fill = "blue") +
  annotate("rect", xmin = 2825, xmax = 3000, ymin = -Inf, ymax = Inf, alpha = 0.1, fill = "red")

# Create the plot with highlighted areas
ggplot(data_long, aes(x = X, y = Intensity, color = Series)) +
  scale_x_reverse(breaks = c(4000,3500,3000, 2500, 2000, 1500, 1000, 500)) +
  geom_line() +
  labs(
    title = expression(paste("Consensus of FTIR spectrum for ", italic("C. megacephala"))),
    x = expression("Wave number cm"^-1),
    y = "Transmittance %"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),  # Center align the title
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)  # Tilt x-axis labels
  ) +
  annotate("rect", xmin = 1350, xmax = 1500, ymin = -Inf, ymax = Inf, alpha = 0.1, fill = "blue") +
  annotate("rect", xmin = 2825, xmax = 3000, ymin = -Inf, ymax = Inf, alpha = 0.1, fill = "red")
