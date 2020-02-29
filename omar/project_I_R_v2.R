data <- read.csv('~/GWU - Blackboard/DSIntro_W_20/Project__I/athlete_events.csv',stringsAsFactors=FALSE) # affects NA conversion to zero
population <- read.csv('~/GWU - Blackboard/DSIntro_W_20/Project__I/pop.csv')
gdp <- read.csv('~/GWU - Blackboard/DSIntro_W_20/Project__I/gdp.csv')
library(dplyr)
library(ggplot2)
library(tidyverse)
# install.packages("rmdformats")
olympics_df <- data.frame(data)
pop_df <- data.frame(population)
gdp_df <- data.frame(gdp)
colnames(pop_df)
unique(colnames(olympics_df))
unique(olympics_df$Year)
olympics_mil <- olympics_df %>% filter(Year >= 2000)
unique(olympics_mil$Year)

pop_df_mil <- pop_df %>% select("Country.Code", "X2000", "X2002", "X2004",
                                "X2006", "X2008","X2010","X2012", "X2014", "X2016")
gdp_df_mil <- gdp_df %>% select("Country.Code", "X2000", "X2002", "X2004",
                                "X2006", "X2008","X2010","X2012", "X2014", "X2016")
colnames(pop_df_mil) = c("NOC", "2000", "2002", "2004", "2006", "2008", "2010",
                         "2012","2014" ,"2016")
colnames(gdp_df_mil) = c("NOC", "2000", "2002", "2004", "2006", "2008", "2010",
                         "2012","2014" ,"2016")
colnames(pop_df_mil)
colnames(gdp_df_mil)
Year <- c(2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016)
Year
pop_df_mil_t <- data.frame(t(pop_df_mil))
View(pop_df_mil_t)
pop_df_mil_t[] <- lapply(pop_df_mil_t, as.character)
colnames(pop_df_mil_t) <- pop_df_mil_t[1,] # the first row will be the header
pop_df_mil_t <- pop_df_mil_t[-1, ]          # removing the first row.
pop_df_mil_t <- stack(pop_df_mil_t)
colnames(pop_df_mil_t) = c('Population', 'NOC')
pop_df_mil_t['Population'] <- lapply(pop_df_mil_t['Population'] , as.numeric)
length(pop_df_mil_t$Population)
pop_df_mil_t$Year <- rep(Year, times = 264)
View(pop_df_mil_t)

gdp_df_mil_t <- data.frame(t(gdp_df_mil))
gdp_df_mil_t[] <- lapply(gdp_df_mil_t, as.character)
colnames(gdp_df_mil_t) = gdp_df_mil_t[1,] # the first row will be the header
gdp_df_mil_t = gdp_df_mil_t[-1, ]          # removing the first row.
gdp_df_mil_t <- stack(gdp_df_mil_t)
colnames(gdp_df_mil_t) = c('GDP', 'NOC')
gdp_df_mil_t['GDP'] <- lapply(gdp_df_mil_t['GDP'] , as.numeric)
length(gdp_df_mil_t$GDP)
gdp_df_mil_t$Year <- rep(Year, times = 264)
View(gdp_df_mil_t)

pop_gdp_mil_df = merge(gdp_df_mil_t, pop_df_mil_t, 
                       by.x=c("NOC", "Year"), 
                       by.y=c("NOC", "Year"))

View(pop_gdp_mil_df)

sum(is.na(pop_gdp_mil_df$GDP))
sum(is.na(pop_gdp_mil_df$Population))

pop_gdp_mil_df$Population[2]

for(i in seq_along(pop_gdp_mil_df$Population))
  {
  if(is.na(pop_gdp_mil_df$Population[i]) & pop_gdp_mil_df$Year[i] <= 2004){
    pop_gdp_mil_df$Population[i] = 
      abs((pop_gdp_mil_df$Population[i+1]/pop_gdp_mil_df$Population[i+2])*
            pop_gdp_mil_df$Population[i+1])
    } else if (is.na(pop_gdp_mil_df$Population[i]) & pop_gdp_mil_df$Year[i] > 2004){
    pop_gdp_mil_df$Population[i] = 
      abs((pop_gdp_mil_df$Population[i-1]/pop_gdp_mil_df$Population[i-2])*
            pop_gdp_mil_df$Population[i-1])
  } else{0
    }
  }

for(i in seq_along(pop_gdp_mil_df$GDP))
{
  if(is.na(pop_gdp_mil_df$GDP[i]) & pop_gdp_mil_df$Year[i] <= 2004){
    pop_gdp_mil_df$GDP[i] = 
      abs((pop_gdp_mil_df$GDP[i+1]/pop_gdp_mil_df$GDP[i+2])*
            pop_gdp_mil_df$GDP[i+1])
  } else if (is.na(pop_gdp_mil_df$GDP[i]) & pop_gdp_mil_df$Year[i] > 2004){
    pop_gdp_mil_df$GDP[i] = 
      abs((pop_gdp_mil_df$GDP[i-1]/pop_gdp_mil_df$GDP[i-2])*
            pop_gdp_mil_df$GDP[i-1])
  } else{0
  }
}

pop_gdp_mil_df[which(is.na(pop_gdp_mil_df$Population)),]
pop_gdp_mil_df[which(is.na(pop_gdp_mil_df$GDP)),]
length(unique(pop_gdp_mil_df$NOC))

olympics_mil %>% filter(NOC=='CUW' )
olympics_mil %>% filter(NOC=='CYM' )
olympics_mil %>% filter(NOC=='GIB' )
olympics_mil %>% filter(NOC=='INX' )
olympics_mil %>% filter(NOC=='MAF' )
olympics_mil %>% filter(NOC=='NCL' )
olympics_mil %>% filter(NOC=='NRU' )
olympics_mil %>% filter(NOC=='PRK' )
olympics_mil %>% filter(NOC=='PYF' )
olympics_mil %>% filter(NOC=='SOM' )
olympics_mil %>% filter(NOC=='SSD' )
olympics_mil %>% filter(NOC=='SXM' )
olympics_mil %>% filter(NOC=='VGB' )
length(unique(olympics_mil$NOC))
length(unique(olympics_mil$Year))
unique(olympics_mil$Year)
# What is different in varss
# difs <- setdiff(varss,varsg)
# setdiff(unique(olympics_mil$NOC),unique(pop_gdp_mil_df$NOC))

setdiff(unique(pop_gdp_mil_df$NOC),unique(olympics_mil$NOC))
head(olympics_mil)
olympics_mil <- olympics_mil %>% filter(!is.na(Height))
olympics_mil <- olympics_mil %>% filter(!is.na(Weight))
sum(is.na(olympics_mil$Medal))

olympics_mil$Medal[is.na(olympics_mil$Medal)] <- 0
# olympics_mil[["Medal"]][is.na(olympics_mil[["Medal"]])] <-0
# olympics_mil$Medal <- replace(olympics_mil$Medal, is.na(olympics_mil$Medal), 0)

oly_gpby_NOC_Yr_Mdl <- olympics_mil %>% group_by(NOC, Year, Medal) %>% tally()
oly_gpby_NOC_Yr_Mdl <- data.frame(oly_gpby_NOC_Yr_Mdl)
# oly_gpby_NOC_Yr_Mdl$tot_medals <- oly_gpby_NOC_Yr_Mdl
# View(oly_gpby_NOC_Yr_Mdl)

# aggregate(n ~ NOC, data=oly_gpby_NOC_Yr_Mdl, FUN=sum ifelse(oly_gpby_NOC_Yr_Mdl$Medal !=0),1,0))
# ?aggregate
# ?merge
# Outer join: merge(x = df1, y = df2, by = "CustomerId", all = TRUE)
# Left outer: merge(x = df1, y = df2, by = "CustomerId", all.x = TRUE)
# Right outer: merge(x = df1, y = df2, by = "CustomerId", all.y = TRUE)
# Cross join: merge(x = df1, y = df2, by = NULL)

pop_gdp_mil_df = merge(oly_gpby_NOC_Yr_Mdl, pop_gdp_mil_df, 
                       by.x=c("NOC", "Year"), 
                       by.y=c("NOC", "Year"))

view(pop_gdp_mil_df)
pop_gdp_mil_df
sum(is.na(pop_gdp_mil_df$Medal))
sum(is.na(pop_gdp_mil_df$GDP))
sum(is.na(pop_gdp_mil_df$Population))
pop_gdp_mil_df[which(is.na(pop_gdp_mil_df$GDP)),]
pop_gdp_mil_df <- pop_gdp_mil_df %>% filter(!is.na(GDP))
pop_gdp_mil_df$GDPpC <- pop_gdp_mil_df$GDP/pop_gdp_mil_df$Population

view(medal_country_df)

sum(pop_gdp_mil_df$n)

ggplot(pop_gdp_mil_df, aes(x=NOC, y=100*(n/sum(n)))) + 
  geom_bar(stat='identity') + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=5))

ggplot(pop_gdp_mil_df, aes(x=NOC, y=n)) + 
  geom_bar(stat='identity') + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=5))

# install.packages('data.table') #may need to be run if you don't have the
library(data.table)
outlierReplace = function(dataframecol, outs, newValue = NA) {
  for (i in seq_along(dataframecol)) {
    if (dataframecol[i] %in% outs) {
      print(dataframecol[i] %in% outs)
      dataframecol[i] = newValue
      print(dataframecol[i])
    }
    else {
      print('not an outlier')
          }
                    }
}
g_outs <- boxplot.stats(pop_gdp_mil_df$GDPpC)$out
p_outs <- boxplot.stats(pop_gdp_mil_df$Population)$out

length(pop_gdp_mil_df[is.na(pop_gdp_mil_df$GDPpC)])
length(boxplot.stats(plot_pop_gdp_mil_df$GDPpC)$out)

plot_pop_gdp_mil_df <- copy(pop_gdp_mil_df)
outlierReplace(plot_pop_gdp_mil_df$GDPpC, g_outs, NA)
outlierReplace(plot_pop_gdp_mil_df$Population, 
               p_outs, NA)

length(plot_pop_gdp_mil_df$GDPpC)
length(plot_pop_gdp_mil_df[is.na(plot_pop_gdp_mil_df$GDPpC)])

mean(pop_gdp_mil_df$GDPpC)

for(x in Year){
  print(x)
  attach(pop_gdp_mil_df %>% filter(Year == x))
  par(mfrow=c(3,1))
  qqnorm(y=GDPpC, 
         main=paste("Olympics participant countries' GDP per Capita QQ-plot for year ",x))
  hist(GDPpC, 
       main=paste("Olympics participant countries' GDP per Capita Histogram for year ",x), breaks =10000)
  boxplot(GDPpC~NOC, 
          pop_gdp_mil_df, main=paste("Olympics participant countries' GDP per Capita boxplot for year ",x))
}


mean(pop_gdp_mil_df$Population)

for(x in Year){
    print(x)
    attach(plot_pop_gdp_mil_df %>% filter(Year == x))
    par(mfrow=c(3,1))
  qqnorm(y=Population, 
         main=paste("Olympics participant countries' population QQ-plot for year ",x))
  hist(Population, 
       main=paste("Olympics participant countries population Histogram for year ",x), breaks=50000000)
  boxplot(Population~NOC, pop_gdp_mil_df, 
          main=paste("Olympics participant countries population-NOC for year ",x))
}

summary(pop_gdp_mil_df['n'])
summary(pop_gdp_mil_df['GDPpC'])
summary(pop_gdp_mil_df['Population'])
shapiro.test(pop_gdp_mil_df$GDPpC) # Shapiro-Wilk test for normality
shapiro.test(pop_gdp_mil_df$Population) # Shapiro-Wilk test for normality
shapiro.test(pop_gdp_mil_df$n)

View(pop_gdp_mil_df)
corr_olympics <- pop_gdp_mil_df %>% filter(!Medal==0)
corr_olympics <- corr_olympics %>% select(NOC, Year, n, GDPpC, Population, GDP)
corr_olympics <- corr_olympics %>% group_by(NOC, Year, n, GDPpC, Population, GDP) %>% tally()
View(corr_olympics)
# add to geom_bar if you want bars to be seprate=> position='dodge'

# install.packages('psych')
library(psych)
pairs.panels(corr_olympics)
# install.packages('corrplot')
library(corrplot)
corrplot.mixed(cor(corr_olympics), order="hclust", tl.col="black")


# ks.test(pop_gdp_mil_df$GDPpC) # Kolmogorov-Smirnov Tests against normal distribution
# oly_NOC_sport <- olympics_mil_slim %>% group_by(NOC, Year, Sport) %>% tally()
# oly_NOC_medal_sport
# ggplot(oly_NOC_sport, aes(x=NOC, y=n, fill=Sport)) + 
#   geom_bar(stat='identity') +
#  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=5))
# count()barplot(Sport~NOC, olympics_mil_slim, main="Boxplot Age", 
#         xlab = 'NOC',ylab = 'Age')

# summary(olympics_mil_slim['Height'])
# summary(olympics_mil_slim['Weight'])
# summary(olympics_mil_slim['Age'])
# for (col in colnames(olympics_mil)){
# barplot()
#  olympics_mil_slim[toString(col)] <- lapply(toString(col) , as.integer)
  
#  print(ggplot(olympics_mil_slim)+ aes(x=col)+
#    geom_histogram()+
#    ggtitle(col, 'Histo'))
  
  #print(ggplot(olympics_mil_slim)+ 
  #  aes(y=olympics_mil_slim[col])+
  #  geom_boxplot(color="red", fill="orange", alpha=0.2)+
  #  ylab(label = 'Calorie content boxplot')+
  #  ggtitle(col, 'BP'))
  
  # print(ggplot(olympics_mil_slim)+ 
  #  aes(sample=olympics_mil_slim[col])+
  #  stat_qq()+
  #  ggtitle(col, 'QQ'))

#for(i in 1:length(unique(a))){
# this.a <- unique(a)[i]
# unique(unique(as.vector(as.matrix(olympics_mil$col))))
# olympics_mil_slim <- olympics_mil %>% select(ID, Name, Sex, Age, Height, 
#                                              Weight, NOC, Games, Year, 
#                                              Season, City, Sport, Medal)

# olympics_mil_slim <- olympics_mil_slim %>% filter(Medal == 'Gold' |
#                                                     Medal == 'Silver' |
#                                                     Medal == 'Bronze')
# attach(olympics_mil)
# par(mfrow=c(3,3))
# qqnorm(y=Weight, main="QQ Weight")
# hist(Weight, main="Histogram Weight")
# boxplot(Weight~NOC, NOC, main="Boxplot Weight")
# qqnorm(y=Height, distribution="norm", main="QQ Height")
# hist(Height, main="Histogram Height")
# boxplot(Height~NOC, NOC, main="Boxplot Height")
# qqnorm(y=Age, distribution="norm", main="QQ Age")
# hist(Age, main="Histogram Age")
# boxplot(Age~NOC, main="Boxplot Age",
#        xlab = 'NOC',
#          ylab = 'Age')
