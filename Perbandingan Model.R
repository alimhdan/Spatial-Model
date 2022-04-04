library(tmap)
library(raster)
library(stats)

#Input Shp File
spcolumb<-shapefile("E:/UNDIP/smt 5/kapsel 1/Pak Hasbi/Data Columbus/columbus.shp")
names(spcolumb)

#Import data 
data=read.delim("E:/UNDIP/smt 5/kapsel 1/Pak Hasbi/Data Columbus/columbus.txt",header=T)
names(data)
head(data,5)

#Menambahkan kolom variabel dalam file shp
spcolumb$crime=data$crime
spcolumb$income=data$income
spcolumb$housing=data$housing
names(spcolumb)

#Menampilkan Columbus
tm_shape(spcolumb) + tm_polygons()
win.graph()
projection(spcolumb) <- CRS("+init=epsg:3395")
win.graph()
tm_shape(spcolumb) + tm_polygons(col="crime")
win.graph()
tm_shape(spcolumb) + tm_polygons(col="income")
win.graph()
tm_shape(spcolumb) + tm_polygons(col="housing")

#Pembentukan Matriks Pembobot
library(spdep)
library(spatialreg)
library(rgdal)
#MATRIKS PEMBOBOT
queen.nb=poly2nb(spcolumb) #Pembobot queen
queen.listw=nb2listw(queen.nb) #convert nb to listw type
queen.columb= queen.listw
queen.columb
#Menyimpan Matriks Pembobot
Matrix_queen = listw2mat(queen.columb)
head.matrix(Matrix_queen)
write.csv(Matrix_queen, "Matriks Bobot Queen Columb.csv")

#Moran Test: Pembobot Queen
moran.test(spcolumb$crime,queen.columb,randomisation=FALSE)
moran.plot(spcolumb$crime,queen.columb)

#PERSAMAAN REGRESI
reg.eq=data$crime~data$income+data$housing
#OLS
reg.OLS=lm(reg.eq,data=spcolumb)
summary(reg.OLS)
#LM Test
lm.LMtests(reg.OLS,queen.columb,test='LMlag') #SAR
#SLX (SCR)
reg.SLX=lmSLX(reg.eq,data=spcolumb, queen.columb)
summary(reg.SLX)
#SAR
reg.SAR=lagsarlm(reg.eq,data=spcolumb, queen.columb)
summary(reg.SAR)
#SEM
reg.SEM=errorsarlm(reg.eq,data=spcolumb, queen.columb)
summary(reg.SEM)
#SDM
reg.SDM=lagsarlm(reg.eq,data=spcolumb, queen.columb,type="mixed")
summary(reg.SDM)
#SDEM
reg.SDEM=errorsarlm(reg.eq,data=spcolumb,queen.columb,etype="emixed")
summary(reg.SDEM)

#Perhitungan AIC
AIC(reg.OLS)
AIC(reg.SLX) #SCR
AIC(reg.SAR)
AIC(reg.SEM)
AIC(reg.SDM)
AIC(reg.SDEM)

#Perbandingan Model
LR.sarlm(reg.SDM,reg.OLS) # SDM vs OLS
LR.sarlm(reg.SDM,reg.SAR) # SDM vs SAR
LR.sarlm(reg.SDM,reg.SLX) # SDM vs SCR
#dan seterusnya

