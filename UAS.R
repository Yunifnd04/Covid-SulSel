# Read Shape File and Data

library(rgdal) #package untuk shapefile
library(readxl) # membaca data dalam format excel
# input Shape file Makassar
setwd("D:/Kuliah/Semester 6/Spasial")
#dsn (data source name)
#layer=layer name
Map_Sulsel=readOGR(dsn="SULSEL",layer="sul-sel")
# atau

View(Map_Sulsel)
# Input Data Kasus Covid 
localised_Sulsel<- read_excel("DataUAS.xlsx")
localised_Sulsel

#dsn (data source name)
#layer=layer name
data.sulsel=readOGR(dsn="SULSEL",layer="sul-sel")
data=cbind(localised_Sulsel,data.sulsel$ID)
plot(data.sulsel)
View(data.sulsel)
head(localised_Sulsel)

#Matriks Pembobot Spasial 
coordinates(data.sulsel)
coord<-coordinates(data.sulsel)
data.sulsel$long <- coord[, 1]
data.sulsel$lat <- coord[, 2]
data.sulsel$ID <- 1:dim(data.sulsel)[1]


library(spdep)
nb <- poly2nb(data.sulsel)
W <- nb2mat(nb, style="B", zero.policy=TRUE)
W

ww<-poly2nb(data.sulsel,row.names(data.sulsel@data),queen = TRUE)
wm=nb2mat(ww,style = 'B')
wm

WW<-W/rowSums(W)
coord <- coordinates(data.sulsel)
Map_Sulsel$long <- coord[, 1]
Map_Sulsel$lat <- coord[, 2]
Map_Sulsel$ID <- 1:dim(data.sulsel@data)[1]

# Calculate Moran's I
library(ape)
Moran.I(localised_Sulsel$Covid19,WW)

# Run Leroux Model
library(CARBayes)
library(MASS)

Covid<-localised_Sulsel
Covid$Exp<-sum(Covid$Covid19)*Covid$Population/sum(Covid$Population)
Covid$Exp

Formula <-Covid$Covid~offset(log(Covid$Exp))
set.seed(1)

#Moran's I and Modification Moran's I
moran.test(localised_Sulsel$Covid19,nb2listw(ww,style = "B"))

Modellocalised <-S.CARlocalised(formula=Formula,
                                data= localised_Sulsel,
                                family="poisson",
                                W=W,
                                G=3,
                                burnin=20000,
                                prior.tau2=c(0.5,0.005),
                                n.sample=60000)



