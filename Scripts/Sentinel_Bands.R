#require(colorSpec)
require(colorspace)


color<-grDevices::hcl.colors(6, palette = "Spectral")


#Sentinel bands for plotting
# from https://sentinels.copernicus.eu/web/sentinel/user-guides/sentinel-2-msi/resolutions/radiometric
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
  #Band8<- 864 21
  annotate("rect", xmin = 864-(21/2), xmax = 864+(21/2), ymin = 0, ymax = 100, alpha = .2)+
  #Band9<-945.1 20
  annotate("rect", xmin = 945.1-(20/2), xmax = 945.1+(20/2), ymin = 0, ymax = 100, alpha = .2)+
  #Band10<-1373.5 31
  annotate("rect", xmin = 1373.5-(31/2), xmax = 1373.5+(31/2), ymin = 0, ymax = 100, alpha = .2)+
  #Band11<-1613.7 91
  annotate("rect", xmin = 1613.7-(91/2), xmax = 1613.7+(91/2), ymin = 0, ymax = 100, alpha = .2)+
  #Band12<-2202.4 175
  annotate("rect", xmin = 2202.4-(175/2), xmax = 2202.4+(175), ymin = 0, ymax = 100, alpha = .2)+
  