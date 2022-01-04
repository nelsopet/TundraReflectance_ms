##Tundra Reflectance manuscript figure generation
#Wet mosses
#Install needed packages
require(spectrolab)
require(tidyverse)
require(scales)
require(dendrogram)
require(hclust)
require(gridExtra)

aviris_d<-read.csv("Data/revised_dimensionality_2019.csv", header=TRUE)
#aviris_d<-read.table("Data/revised_dimensionality_2019 (1).txt", header=FALSE) %>% 
#  as.data.frame() 
#dim(aviris_d) #[1] 5004   11

#aviris_d_colnames<-read_table("Data/revised_dimensionality_2019 (1).txt", col_names=FALSE, n_max =1) %>% t()# %>% as.data.frame()

#colnames(aviris_d)<-aviris_d_colnames[2:12] %>% str_remove(',')
#aviris_d %>%  mutate(Wavelength = str_remove(Wavelength, "X"))
#head(aviris_d)
#aviris_d<-
#aviris_d %>%
#  mutate(dimensionality = as.numeric(dimensionality))


aviris_d$ndvi_mean<-ifelse(is.nan(aviris_d$ndvi_mean)==TRUE, 0, aviris_d$ndvi_mean)
aviris_d$ndvi_stdev<-ifelse(is.nan(aviris_d$ndvi_stdev)==TRUE, 0, aviris_d$ndvi_stdev)

lapply(2:ncol(aviris_d), function(x) {range(aviris_d[,x])} ) 

aviris_d_filt <- aviris_d %>% filter(ndvi_stdev<1) %>% filter(latitude_stdev<50)#%>% filter(longitude_stdev<50)

#After filtering out high variability NDVI samples,
#Dimensionality has s roughly unimodal shape vs ndvi_mean and clouds, others no so clear

# pairs(aviris_d_filt[2:11])
#[1] "#"                "flightline,"      "latitude_mean,"   "longitude_mean," 
#[5] "elevation_mean,"  "latitude_stdev,"  "longitude_stdev," "elevation_stdev,"
#[9] "cloud_fraction,"  "ndvi_mean,"       "ndvi_stdev,"      "dimensionality" 

lat_v_dim_gg<-ggplot(aviris_d_filt, aes(latitude_mean,latitude_stdev))+#geom_line()
  geom_point(aes(color=log2(dimensionality)))

elev_v_dim_gg<-ggplot(aviris_d_filt, aes(elevation_mean,dimensionality))+geom_line()+geom_smooth()
  #geom_point(aes(color=log2(dimensionality)))
  
ggplot(aviris_d_filt, aes(latitude_mean,latitude_stdev,dimensionality))+
  geom_point(aes(color=log2(dimensionality)))

ggplot(aviris_d_filt, aes(elevation_mean,elevation_stdev,dimensionality))+
  geom_hex(aes(color=log2(dimensionality)))

ggplot(aviris_d_filt, aes(elevation_mean,elevation_stdev,dimensionality))+
  geom_hex(aes(color=log2(dimensionality))) +
  geom_smooth()

ggplot(aviris_d, aes(elevation_mean,latitude_mean,dimensionality))+
  geom_hex(aes(color=dimensionality))

ggplot(aviris_d_filt, aes(ndvi_mean,ndvi_stdev))+
  geom_point(aes(color=dimensionality))
  geom_hex(aes(color=dimensionality))

tst<-aviris_d_filt %>% dplyr::select(ndvi_mean, ndvi_stdev)
ndvi_dist<-dist(tst)
ndvi_clust<-hclust(ndvi_dist) #%>% hist()
ndvi_clust_4grp<-cutree(ndvi_clust,4)
plot(ndvi_clust_4grp)


aviris_d_filt$ndvi_group = as.factor(ndvi_clust_4grp)



p1<-ggplot(aviris_d_filt, aes(ndvi_mean,ndvi_stdev))+
  geom_point(aes(color=dimensionality, shape = ndvi_group, size = elevation_mean))+
  theme_bw()


p2<-ggplot(aviris_d_filt, aes(longitude_mean,latitude_mean))+
  geom_point(aes(color = ndvi_group)) +theme_minimal()

jpeg("Output/Dimensions_NDVI.jpeg", height = 300*5, width =900*5, res= 350)
grid.arrange(p1,p2, nrow=1)
dev.off()

aviris_d_ndvi<-aviris_d_filt %>% filter(ndvi_group==2)

ggplot(aviris_d_ndvi, aes(ndvi_mean,ndvi_stdev))+
  geom_point(aes(color=dimensionality, size=elevation_mean))


#Assign clusters to identity based on position in XY space of NDVI mean and st dev
#Plot flightlines by lat long and color by group

help(dist)
