ggplot(mtcars, aes(wt, mpg)) + 
     geom_point(aes(colour = cut(qsec, c(-Inf, 17, 19, Inf))),size = 5) #+

               
  scale_color_manual(name = "qsec",
                     values = c("(-Inf,17]" = "black",
                                "(17,19]" = "yellow",
                                "(19, Inf]" = "red"),
                     labels = c("<= 17", "17 < qsec <= 19", "> 19"))


ggplot(tst_new,aes(Wavelength, Mean_Reflectance))+
  geom_point(aes(color = cut(Moisture,c(-Inf,0.3,0.6,Inf))), size=0.5) + 
  #geom_point(aes(color = cut(Moisture,c(0,0.3,0.6,1))), size=0.5) + 
  
  #  geom_point(aes(colour = cut(Moisture, breaks = 3))) + #, size = 1, alpha = 0.5) +
  
  scale_colour_manual(name = "Deviation",
                      values = c("(-Inf,29e-2]"  = "lightblue1",
                                 "(3e-1,59e-2]" = "mediumblue",
                                 "(6e-1,Inf]" = "darkblue"),
                      labels = c("0.81-0.88", "0.51-0.6", "0.81-0.88"))  #  +

scale_colour_manual(name = "Deviation",
                    values = c("(0,29e-2]"  = "lightblue1",
                               "(3e-1,59e-2]" = "mediumblue",
                               "(6e-1,1]" = "darkblue"),
                    labels = c("0.81-0.88", "0.51-0.6", "0.81-0.88"))  #  +

  
  
  
labs(title = c("Reflectance of Sphagnum sp. by deviation from saturated mass with \n vertical grey bars showing Landsat 8 bandpasses "), y="Reflectance")+
  #theme(panel.background = element_rect(fill = "white", colour = "white"), 
  #      #legend.key.size = 4,
  #      title = element_text(size=25),
  #      strip.text = element_text(size = 25),
  #      axis.text = element_text(size = 20),
  #      axis.text.x = element_text(angle = 90)) +
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
 