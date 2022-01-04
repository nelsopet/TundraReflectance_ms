#Landsat bands for plotting
#Band1<-c(430,450)#Band 1 - Coastal aerosol	0.43-0.45	30
annotate("rect", xmin = 430, xmax = 450, ymin = 0, ymax = 100, alpha = .2)+
#Band2<-c(450,510)#Band 2 - Blue	0.45-0.51	30
annotate("rect", xmin = 450, xmax = 510, ymin = 0, ymax = 100, alpha = .2)+
#Band3<-c(530,590)#Band 3 - Green	0.53-0.59	30
annotate("rect", xmin = 530, xmax = 590, ymin = 0, ymax = 100, alpha = .2)+
#Band4<-c(640,670)#Band 4 - Red	0.64-0.67	30
annotate("rect", xmin = 640, xmax = 670, ymin = 0, ymax = 100, alpha = .2)+
#Band5<-c(850-880)#Band 5 - Near Infrared (NIR)	0.85-0.88	30
annotate("rect", xmin = 850, xmax = 880, ymin = 0, ymax = 100, alpha = .2)+
#Band6<-c(1157,1650)#Band 6 - SWIR 1	1.57-1.65	30
annotate("rect", xmin = 1157, xmax = 1650, ymin = 0, ymax = 100, alpha = .2)+
#Band7<-c(2110,2290)#Band 7 - SWIR 2	2.11-2.29	30
annotate("rect", xmin = 2110, xmax = 229, ymin = 0, ymax = 100, alpha = .2)

#Band 8 - Panchromatic	0.50-0.68	15
#Band 9 - Cirrus	1.36-1.38	30
#Band 10 - Thermal Infrared (TIRS) 1	10.6-11.19	100
#Band 11 - Thermal Infrared (TIRS) 2	11.50-12.51	100