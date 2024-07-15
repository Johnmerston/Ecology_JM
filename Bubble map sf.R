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


ggplot() +
  geom_sf(data = stream_sf, color = "black", size = 1) +
  geom_jitter(data = stream_data_long, aes(x = x, y = y, size = population, color = population_type), 
              width = 0.5, height = 0.5, alpha = 0.7) +
  theme_minimal() +
  ggtitle("Stream Plot with Two Sets of Population Bubbles (Jittered)") +
  xlab("Longitude") +
  ylab("Latitude") +
  scale_size_continuous(range = c(1, 20)) +  # Adjust the range as needed
  scale_color_manual(values = c("population1" = "red", "population2" = "blue"))  # Adjust colors as needed

