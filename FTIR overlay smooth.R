library(signal)
library(ggplot2)
library(tidyr)
library(readxl)

# Reading the data from the provided file
Test_file <- read_xlsx("C:\\JOHN\\OTHERS\\BALU\\FTIR\\CMs.xlsx")

# Converting the data to a data frame and ensuring column names are correct
colnames(Test_file) <- c("X", "CM_1", "CM_2", "CM_3", "CM_4")
Test_df <- as.data.frame(Test_file)

# Ensuring X and CM_* columns are numeric
Test_df$X <- as.numeric(Test_df$X)
Test_df$CM_1 <- as.numeric(Test_df$CM_1)
Test_df$CM_2 <- as.numeric(Test_df$CM_2)
Test_df$CM_3 <- as.numeric(Test_df$CM_3)
Test_df$CM_4 <- as.numeric(Test_df$CM_4)

# Define window size and polynomial order
window_size <- 21
poly_order <- 3

# Apply Savitzky-Golay smoothing
Test_df$CM_smooth_1 <- sgolayfilt(Test_df$CM_1, p = poly_order, n = window_size)
Test_df$CM_smooth_2 <- sgolayfilt(Test_df$CM_2, p = poly_order, n = window_size)
Test_df$CM_smooth_3 <- sgolayfilt(Test_df$CM_3, p = poly_order, n = window_size)
Test_df$CM_smooth_4 <- sgolayfilt(Test_df$CM_4, p = poly_order, n = window_size)

Test_df$CM_H1 <- Test_df$CM_smooth_1
Test_df$CM_H2 <- Test_df$CM_smooth_2
Test_df$CM_H3 <- Test_df$CM_smooth_3
Test_df$CM_H4 <- Test_df$CM_smooth_4

# Transform the data into a long format
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
