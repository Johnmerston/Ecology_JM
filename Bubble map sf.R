#while plotting maps, it is important to note that the distance between a unit lattitude and longitude are not the same.
#sf package comes built in with pre-callibrated distances between lattitudes and longitudes thus enabling plots through sf to resemeble a trace drawn from a physical map
library(ggplot2)
library(sf)
library(tidyr)

stream_data <- data.frame(
  x = c(10, 11, 15, 13, 25, 26, 29, 35),
  y = c(15, 25, 35, 45, 55, 40, 50, 55),
  population1 = c(25, 10, 37, 47, 18, 46, 8, 10),
  population2 = c(15, 35 , 34, 23, 23, 24, 14, 53)
)

# Create a matrix of coordinates
coords <- as.matrix(stream_data[, c("x", "y")])

# Create an sf object with a linestring
stream_sf <- st_sf(geometry = st_sfc(st_linestring(coords)))

# Reshape the data to long format for plotting
stream_data_long <- tidyr::pivot_longer(
  stream_data,
  cols = c(population1, population2),
  names_to = "population_type",
  values_to = "population"
)

# Plot the data with different colors for each population set and a black line
ggplot() +
  geom_sf(data = stream_sf, color = "black", size = 1) +
  geom_point(data = stream_data_long, aes(x = x, y = y, size = population, color = population_type), alpha = 0.7) +
  theme_classic() +
  ggtitle("Stream Plot with Two Sets of Population Bubbles") +
  xlab("Longitude") +
  ylab("Latitude") +
  scale_size_continuous(range = c(3, 10)) +  # Adjust the range as needed
  scale_color_manual(values = c("population1" = "red", "population2" = "blue"))# Adjust colors as needed


#There is a reason why we use sf package to plot a bubble map instead of using geom_path in ggplot2.
#for better understanding, try coding the same data using the below codes that run geom_path feature and see the difference.
library(ggplot2)
library(tidyr)

# Your data
stream_data <- data.frame(
  x = c(10, 11, 15, 13, 25, 26, 29, 35),
  y = c(15, 25, 35, 45, 55, 40, 50, 55),
  population1 = c(25, 10, 37, 47, 18, 46, 8, 10),
  population2 = c(15, 35 , 34, 23, 23, 24, 14, 53)
)

# Reshape the data to long format for plotting
stream_data_long <- tidyr::pivot_longer(
  stream_data,
  cols = c(population1, population2),
  names_to = "population_type",
  values_to = "population"
)

# Plot the data with geom_path
ggplot() +
  geom_path(data = stream_data, aes(x = x, y = y), color = "black", linewidth = 1) +
  geom_point(data = stream_data_long, aes(x = x, y = y, size = population, color = population_type), alpha = 0.7) +
  theme_classic() +
  ggtitle("Stream Plot with Two Sets of Population Bubbles") +
  xlab("Longitude") +
  ylab("Latitude") +
  scale_size_continuous(range = c(3, 10)) +  # Adjust the range as needed
  scale_color_manual(values = c("population1" = "red", "population2" = "blue"))  # Adjust colors as needed


