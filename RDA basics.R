#creating an R file to save codes to perform RDA
#note that the data used in the following tutorial has been AI generated using mockarro.com

#calling library for reading excel files
library(readxl)

#Bringing the xlsx file into Rstudio
Main_file <- read_excel("C:/JOHN/BOREDOM/DATA/MOCK_DATA.xlsx")

#now that the data has been brought into RStudio, the data can be categorized based on it being a dependent or independant factor

Species_data <- Main_file[,c("species population")]
Environ_data <- Main_file[,c("temperature","humidity","air_quality_index", "wind_speed","precipitation", "sunlight_exposure","soil_ph_level", "water_ph_level", "carbon_dioxide_level",	"oxygen_level", "noise_level", "light_intensity", "pollen_count", "water_temperature", "air_pressure", "water_level", "biodiversity_index",	"deforestation_rate",	"coastal_erosion_rate")]

#Now that the data has been categorized, we can proceed with the initial step of data processing
#standardizing data is the first step of data processing. It ensures that the degree of variaton within each of the parameters is established to the system. This further helps with prevention of errors when the system evaluates paramenters that are numberically distant from each other.

Species_std <- scale(Species_data)
Environ_std <- scale(Environ_data)

#Standardized paper can now be taken to perform RDA
#Calling libraries required for performing RDA

library(permute)
library(lattice)
library(vegan)

RDA_result <- rda(Species_std, Environ_std)
summary(RDA_result)
plot(RDA_result)
