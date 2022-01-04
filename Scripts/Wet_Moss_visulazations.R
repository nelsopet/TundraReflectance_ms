#Tundra Reflectance manuscript figure generation
#Wet mosses
#Install needed packages
require(spectrolab)
require(tidyverse)
#require(scales)
#require(colorSpec)
color<-grDevices::hcl.colors(6, palette = "Spectral", rev= TRUE)
dev_col<-grDevices::hcl.colors(3, palette = "Blues 3") %>% as.data.frame() %>% rename(color = ".") #%>% 
dev_col$color_simple<-c("lightblue1","mediumblue", "darkblue")
dev_col$Deviation_nm<-seq(1:3)
tst_val<-c(1,2,3) %>% as.data.frame() %>% rename( x = ".")
tst_val$color_simple<-c("lightblue1","mediumblue", "darkblue")
tst_val$y<-c(1,2,3)
plot(tst_val$x,tst_val$y)#, col = tst_val$color_simple)


dev_col$Deviation<-c("0.21-0.29","0.51-0.6","0.81-0.88")

#Read in data
list.files("Data")
#[1] "peter_moss_subset.csv"           "revised_dimensionality_2019.txt"
wet_moss<-read.csv("Data/peter_moss_subset.csv")
dim(wet_moss)
#wet_moss %>% group_by(moss.moisture..,ID) %>% tally() %>% pivot_wider(names_from = ID, values_from = n) %>% View()
#[1] 0.21 0.22 0.23 0.24 0.25 0.27 0.28 0.29 0.51 0.52 0.53 0.55 0.56 0.57 0.59 0.60 0.81 0.82
#[19] 0.83 0.84 0.85 0.86 0.87 0.88
#moist_levels<-c(0.24,0.25,0.27,0.51,0.52,0.53, 0.84,0.85,0.86)


wet_moss$ID<-ifelse(wet_moss$ID=="OS", "S. lenense", wet_moss$ID)
wet_moss$ID<-ifelse(wet_moss$ID=="RS", "S. capillifolium", wet_moss$ID)
#range of Wavelength 338.1 2515.9

  wet_moss_filt<-
  wet_moss %>% 
  rename(Moisture = `moss.moisture..`) %>%
  #filter(Moisture %in% moist_levels) %>%
  pivot_longer(cols = `X338.1`:`X2515.9`,  names_to  = "Wavelength", values_to = "Reflectance") %>%
  mutate(
    Wavelength = str_remove(Wavelength, "X"),  
   Wavelength = as.numeric(Wavelength)
  ) %>%
  as.data.frame() %>% #group_by(ID, Moisture) %>% tally()
    mutate(Deviation = ifelse(Moisture<0.3, "0.21-0.29", ifelse(Moisture>=0.3&Moisture<0.6, "0.51-0.6", "0.81-0.88"))) %>%
    group_by(ID, Deviation, Wavelength) %>%
    summarise(Mean_Reflectance = mean(Reflectance))
    #filter(Moisture >= 0.82 & Moisture <= 0.87 | Moisture >=0.52 & Moisture<= 0.57 | Moisture >=0.22|Moisture <= 0.27)
  
  
  ggplot(wet_moss_filt,aes(Wavelength, Mean_Reflectance))+
    #labs(title = c("Reflectance of Sphagnum sp. by deviation from saturated mass with \n vertical grey bars showing Landsat 8 bandpasses "), y="Reflectance")+
    labs(x= "Fraction of saturated water mass", y="Reflectance")+
    
        theme(panel.background = element_rect(fill = "white", colour = "white"), 
          #legend.key.size = 4,
          title = element_text(size=25),
          strip.text = element_text(size = 25),
          axis.text = element_text(size = 20),
          axis.text.x = element_text(angle = 90)) +
    #Sentinel bands for plotting
    #Band 1
    annotate("rect", xmin = 442.7-(21/2), xmax = 442.7+(21/2), ymin = 0, ymax = 100, alpha = .2, color=color[1])+
    #Band2
    annotate("rect", xmin = 492.4-(66/2), xmax = 492.4+(66/2), ymin = 0, ymax = 100, alpha = .2, color=color[2])+
    #Band3 559.8 36
    annotate("rect", xmin = 559.8-(36/2), xmax = 559.8+(36/2), ymin = 0, ymax = 100, alpha = .2,color=color[3])+
    #Band4 664.6 31
    annotate("rect", xmin = 664.6-(31/2), xmax = 664.6+(31/2), ymin = 0, ymax = 100, alpha = .2,color=color[4])+
    #Band5 704.1 15
    annotate("rect", xmin = 704.1-(15/2), xmax = 704.1+(15/2), ymin = 0, ymax = 100, alpha = .2,color=color[5])+
    #Band6<-740.5 15
    annotate("rect", xmin = 740.5-(15/2), xmax = 740.5+(15/2), ymin = 0, ymax = 100, alpha = .2,color=color[6])+
    #Band7<-782.8 20
    annotate("rect", xmin = 782.8-(20/2), xmax = 782.8+(20/2), ymin = 0, ymax = 100, alpha = .2)+
    #Band8<- 832.8 106
    annotate("rect", xmin = 832.8-(106/2), xmax = 832.8+(106/2), ymin = 0, ymax = 100, alpha = .2)+
    #Band9<-945.1 20
    annotate("rect", xmin = 945.1-(20/2), xmax = 945.1+(20/2), ymin = 0, ymax = 100, alpha = .2)+
    #Band10<-1373.5 31
    annotate("rect", xmin = 1373.5-(31/2), xmax = 1373.5+(31/2), ymin = 0, ymax = 100, alpha = .2)+
    #Band11<-1613.7 91
    annotate("rect", xmin = 1613.7-(91/2), xmax = 1613.7+(91/2), ymin = 0, ymax = 100, alpha = .2)+
    #Band12<-2202.4 175
    annotate("rect", xmin = 2202.4-(175/2), xmax = 2202.4+(175), ymin = 0, ymax = 100, alpha = .2)+
    #geom_point(aes(Deviation, colour = cut(Deviation_nm, breaks = c(1,2,3)))) + #, size = 1, alpha = 0.5) +     
    geom_point(aes(colour = Deviation)) + #, size = 1, alpha = 0.5) +     
  facet_wrap(vars(ID), scales = "fixed", ncol = 2) 
  
    scale_colour_manual(name = "Fraction of saturated water mass",
                        values = c("1"  = "lightblue1",
                                   "2" = "mediumblue",
                                   "3" = "darkblue"),
                        labels = c("0.21-0.29", "0.51-0.6", "0.81-0.88"))    +
    
    # geom_point(aes(color=Deviation)) + #, size = 1, alpha = 0.5) +
    facet_wrap(vars(ID), scales = "fixed", ncol = 2) 
  
  
  
  meta_data_filt_spec<-wet_moss_filt %>%
    ungroup() %>%
    pivot_wider(names_from = Wavelength, values_from = Mean_Reflectance) %>% dplyr::select(ID, Deviation)
#Reflatten cleaned data to resample as a spectral object
  
    wet_moss_filt_spec<-wet_moss_filt %>%
    ungroup() %>%
    pivot_wider(names_from = Wavelength, values_from = Mean_Reflectance) %>% #head()
    dplyr::select(-ID:-Deviation) %>%
    as_spectra() #%>% 
    
    meta(wet_moss_filt_spec, label=c("Species","Deviation"))<-meta_data_filt_spec
    meta(wet_moss_filt_spec)
    wet_moss_filt_resamp20nm<-
    wet_moss_filt_spec %>%
  spectrolab::resample(new_bands = seq(450, 2400, 5), parallel = FALSE)

#plot_interactive(wet_moss_filt_resamp20nm)  
  
tst_new<-wet_moss_filt_resamp20nm %>% 
  as.data.frame() %>%
  #cbind(wet_moss[1:2]) %>%
  #rename(Moisture = `moss.moisture..`) %>%
  pivot_longer(cols = `450`:`2400`,  names_to  = "Wavelength", values_to = "Reflectance") %>%
  mutate(
   # Wavelength = str_remove(Wavelength, "X"),  
    Wavelength = as.numeric(Wavelength)
  ) %>%
  as.data.frame() %>% #group_by(ID, Moisture) %>% tally()
  #mutate(Deviation = ifelse(Moisture<0.3, "0.21-0.29", ifelse(Moisture>=0.3&Moisture<0.6, "0.51-0.6", "0.81-0.88"))) %>% 
  #group_by(ID, Deviation, Wavelength) %>%
  left_join(dev_col,by="Deviation", keep=FALSE) %>%
  ungroup() %>%
  as.data.frame() %>%
  group_by(Species, Deviation, Deviation_nm, Wavelength) %>% #tally() %>% pivot_wider(names_from = c(ID, Deviation), values_from = n)
  summarise(Mean_Reflectance = mean(Reflectance)) #%>%

  
jpeg("Output/Moss_hydration.jpg", height = 2000, width = 4000, res = 350)
ggplot(tst_new,aes(Wavelength, Mean_Reflectance))+
  #labs(title = c("Reflectance of Sphagnum species by deviation from saturated \n mass with vertical bars showing Sentinel-2 bandpasses"), y="Reflectance")+
    
  labs(x= "Wavelength (nm)", y="Reflectance")+
  
  theme(panel.background = element_rect(fill = "white", colour = "white"), 
          legend.key.size = unit(2, 'cm'),
          legend.text = element_text(size=20),
          legend.key.height= unit(0.5, 'cm'),
          legend.key.width= unit(0.5, 'cm'),
          title = element_text(size=25),
          strip.text = element_text(size = 25, face="italic"),
          axis.text = element_text(size = 20),
          axis.text.x = element_text(angle = 90),
          plot.title = element_text(size = 25)) +
    #Sentinel bands for plotting
    #Band 1
    annotate("rect", xmin = 442.7-(21/2), xmax = 442.7+(21/2), ymin = 0, ymax = 100, alpha = .7, fill =color[1])+#
    #Band2, fill =#
    annotate("rect", xmin = 492.4-(66/2), xmax = 492.4+(66/2), ymin = 0, ymax = 100, alpha = .7, fill =color[2])+#
    #Band3 559.8 36, fill =#
    annotate("rect", xmin = 559.8-(36/2), xmax = 559.8+(36/2), ymin = 0, ymax = 100, alpha = .7, fill =color[3])+#
    #Band4 664.6 31, fill =#
    annotate("rect", xmin = 664.6-(31/2), xmax = 664.6+(31/2), ymin = 0, ymax = 100, alpha = .7, fill =color[4])+#
    #Band5 704.1 15, fill =#
    annotate("rect", xmin = 704.1-(15/2), xmax = 704.1+(15/2), ymin = 0, ymax = 100, alpha = .7, fill =color[5])+#
    #Band6<-740.5 15, fill =#
    annotate("rect", xmin = 740.5-(15/2), xmax = 740.5+(15/2), ymin = 0, ymax = 100, alpha = .7, fill = color[6])+#
    #Band7<-782.8 20
    annotate("rect", xmin = 782.8-(20/2), xmax = 782.8+(20/2), ymin = 0, ymax = 100, alpha = .7)+
    #Band8<- 864 21
    annotate("rect", xmin = 864-(21/2), xmax = 864+(21/2), ymin = 0, ymax = 100, alpha = .7)+
    #Band9<-945.1 20
    annotate("rect", xmin = 945.1-(20/2), xmax = 945.1+(20/2), ymin = 0, ymax = 100, alpha = .7)+
    #Band10<-1373.5 31
    annotate("rect", xmin = 1373.5-(31/2), xmax = 1373.5+(31/2), ymin = 0, ymax = 100, alpha = .7)+
    #Band11<-1613.7 91
    annotate("rect", xmin = 1613.7-(91/2), xmax = 1613.7+(91/2), ymin = 0, ymax = 100, alpha = .7)+
    #Band12<-2202.4 175
    annotate("rect", xmin = 2202.4-(175/2), xmax = 2202.4+(175), ymin = 0, ymax = 100, alpha = .7)+
    geom_point(aes(colour = cut(Deviation_nm, breaks = c(-Inf,1,2,Inf))), size = 1) + #, size = 1, alpha = 0.5) +     
  #geom_point(aes(colour = Deviation)) + #, size = 1, alpha = 0.5) +     
    scale_color_manual(
name = "Fraction of\nsaturated\nwater mass",
values = c("(-Inf,1]" = "lightblue1",
           "(1,2]" = "mediumblue",
           "(2, Inf]" = "darkblue"),
            labels = c("0.21.-0.29", "0.51-0.6", "0.81-0.88"))    +
     
    # geom_point(aes(color=Deviation)) + #, size = 1, alpha = 0.5) +
          facet_wrap(vars(Species), scales = "fixed", ncol = 2) 
  dev.off()
  
  