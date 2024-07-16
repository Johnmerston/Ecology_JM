install.packages("factoextra")
library(factoextra)
library(ggplot2)
library(factoextra)
library(readxl)

#bring data into Rstudio

PCA_raw <- read_xlsx("C:\\JOHN\\BOREDOM\\DATA\\PCA mock.xlsx")

#standardazing data

PCA_scaled <- scale(PCA_raw)

#performing PCA

PCA_result <- prcomp(PCA_scaled)
summary(PCA_result)
PCA_result$rotation
PCA_result$x


fviz_eig(PCA_result)

fviz_pca_biplot(PCA_result, display = "bp")

fviz_pca_ind(PCA_result)

fviz_pca_ind(PCA_result,
             addEllipses = TRUE,
             ellipse.type = "confidence"
             )

fviz_pca_ind(PCA_result,
             addEllipses = TRUE,
             ellipse.type = "euclid"
             )

fviz_pca_ind(PCA_result,
             addEllipses = TRUE,
             ellipse.type = "norm"
             )


fviz_pca_ind(PCA_result,
             addEllipses = TRUE,
             ellipse.type = "t"
             )

fviz_pca_ind(PCA_result,
             addEllipses = TRUE,
             ellipse.type = "convex"
             )


fviz_pca_var(PCA_result, repel = TRUE)

