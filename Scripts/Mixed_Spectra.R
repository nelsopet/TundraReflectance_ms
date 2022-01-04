#Read in Scott David's students mixed-pixel spectra.
list.files("Data")
require(readxl)
require(tidyverse)
require(glue)

color<-grDevices::hcl.colors(6, palette = "Spectral", rev= TRUE)

tundra_mix<-read_xlsx("Data/spectra_mixed_tundra_spec_paper_sjdavidson.xlsx", sheet="spectra_mixed_tundra_spec_paper")
tundra_mix<-tundra_mix %>% mutate(Veg_community_wN = glue('{veg_community} {"(n="} {n()})'))

dim(tundra_mix)

tundra_mix_wide<-read_xlsx("Data/spectra_mixed_tundra_spec_paper_sjdavidson.xlsx", sheet="Sheet1")
dim(tundra_mix_wide)
tundra_mix_wide<-tundra_mix_wide %>%
pivot_longer(cols = `402`:`1000`,  names_to  = "Wavelength", values_to = "Reflectance") %>%
  dplyr::filter(is.na(Site)==FALSE)  %>%
  group_by(Wavelength, veg_community) %>%
  mutate(Veg_community_wN = glue('{veg_community} {"(n="} {n()})')) %>%
  mutate(Wavelength=as.numeric(Wavelength)) %>%
  dplyr::filter(Wavelength<850)
  
str(tundra_mix)
dim(tundra_mix_wide)


jpeg("Output/Mixed_Tundra_spectra.jpg", height = 10000, width = 9000, res=350)
ggplot(tundra_mix_wide, aes(Wavelength, Reflectance))+
  #geom_hex() +

    #geom_ribbon(aes(Wavelength, ymin = Pct_12_5_Reflectance, ymax = Pct_87_5_Reflectance, alpha = 0.3))+
  #geom_ribbon(aes(Wavelength, ymin = Lower_Reflectance, ymax = Upper_Reflectance, alpha = 0.2))+
  #labs(title = c("Mixed vegetation reflectance by community with sample size \n and vertical grey bars showing Sentinel-2 bandpasses"), y="Reflectance")+
  labs(x="Wavlength (nm)", y="Reflectance")+
  
  theme(panel.background = element_rect(fill = "white", colour = "grey50"), 
        #legend.key.size = unit(2, 'cm'),
        #legend.text = element_text(size=18),
        legend.position = "none",
        title = element_text(size=45),
        strip.text = element_text(size = 35),
        axis.text = element_text(size = 35),
        axis.text.x = element_text(angle = 90)
        ) +
  #Sentinel bands for plotting
  #Band 1
  annotate("rect", xmin = 442.7-(21/2), xmax = 442.7+(21/2), ymin = 0, ymax = 0.5, alpha = 0.7, fill =color[1])+
  #Band2, fill =
  annotate("rect", xmin = 492.4-(66/2), xmax = 492.4+(66/2), ymin = 0, ymax = 0.5, alpha = 0.7, fill =color[2])+
  #Band3 559.8 36, fill =
  annotate("rect", xmin = 559.8-(36/2), xmax = 559.8+(36/2), ymin = 0, ymax = 0.5, alpha = 0.7,fill =color[3])+
  #Band4 664.6 31, fill =
  annotate("rect", xmin = 664.6-(31/2), xmax = 664.6+(31/2), ymin = 0, ymax = 0.5, alpha = 0.7,fill =color[4])+
  #Band5 704.1 15, fill =
  annotate("rect", xmin = 704.1-(15/2), xmax = 704.1+(15/2), ymin = 0, ymax = 0.5, alpha = 0.7,fill =color[5])+
  #Band6<-740.5 15, fill =
  annotate("rect", xmin = 740.5-(15/2), xmax = 740.5+(15/2), ymin = 0, ymax = 0.5, alpha = 0.7,fill = color[6])+
  #Band7<-782.8 20
  annotate("rect", xmin = 782.8-(20/2), xmax = 782.8+(20/2), ymin = 0, ymax = 0.5, alpha = 0.7)+
  #Band8<- 864 21
  #annotate("rect", xmin = 864-(21/2), xmax = 864+(21/2), ymin = 0, ymax = 0.5, alpha = .2)+
  ##Band9<-945.1 20
  #annotate("rect", xmin = 945.1-(20/2), xmax = 945.1+(20/2), ymin = 0, ymax = 0.5, alpha = .2)+
  ##Band10<-1373.5 31
  #annotate("rect", xmin = 1373.5-(31/2), xmax = 1373.5+(31/2), ymin = 0, ymax = 1, alpha = .2)+
  ##Band11<-1613.7 91
  #annotate("rect", xmin = 1613.7-(91/2), xmax = 1613.7+(91/2), ymin = 0, ymax = 1, alpha = .2)+
  ##Band12<-2202.4 175
  #annotate("rect", xmin = 2202.4-(175/2), xmax = 2202.4+(175), ymin = 0, ymax = 1, alpha = .2)+
  
  #scale_color_manual(values = rev(cols))+
  geom_point(size = 1.5, alpha = 0.1) +
  
  facet_wrap(vars(Site,Veg_community_wN), scales = "fixed", ncol = 2) 

dev.off()
