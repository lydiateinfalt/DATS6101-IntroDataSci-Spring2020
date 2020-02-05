data <- read.csv('~/GWU - Blackboard/DSIntro_W_20/Project__I/athlete_events.csv')
library(dplyr)
olympics_df <- data.frame(data)
olympics_mil <- olympics_df %>% filter(Year >= 2000)

for (col in colnames(olympics_mil)){
  print(col)
  print(sum(is.na(olympics_mil[as.character(col)])))
  }

olympics_mil[which(is.na(olympics_mil[,'Age'])),]
olympics_mil[which(is.na(olympics_mil[,'Height'])),]
olympics_mil[which(is.na(olympics_mil[,'Weight'])),]

for (col in colnames(olympics_mil)){
  print(col)
  print(length(unique(unlist(olympics_mil[as.character(col)]))))
  print(as.list(unique(unlist(olympics_mil[as.character(col)]))))
}

olympics_mil_slim <- olympics_mil %>% select(ID, Name, Sex, Age, Height, Weight, NOC, 
                                             Games, Year, Season, City, Sport, Medal)
olympics_mil_slim <- olympics_mil_slim %>% filter(Medal == 'Gold' | Medal == 'Silver' | Medal == 'Bronze')

length(olympics_mil_slim$ID)

for (col in colnames(olympics_mil_slim)){
  print(col)
  print(sum(is.na(olympics_mil_slim[as.character(col)])))
}

olympics_mil_slim[which(is.na(olympics_mil[,'Height'])),]
olympics_mil_slim[which(is.na(olympics_mil_slim[,'Weight'])),]

olympics_mil_slim <- olympics_mil_slim %>% filter(!is.na(Height))
olympics_mil_slim <- olympics_mil_slim %>% filter(!is.na(Weight))

for (col in colnames(olympics_mil_slim)){
  print(col)
  print(sum(is.na(olympics_mil_slim[as.character(col)])))
}

for (col in colnames(olympics_mil_slim)){
  print(col)
  print(length(unique(unlist(olympics_mil_slim[as.character(col)]))))
  print(as.list(unique(unlist(olympics_mil_slim[as.character(col)]))))
}

num_column_names = c('Height', 'Weight', 'Age')
cat_column_names = c('Sex', 'NOC', 'Season', 'Sport', 'Medal')

sapply(olympics_mil_slim['Age'], class)

attach(olympics_mil_slim)
par(mfrow=c(3,3))
qqnorm(y=Weight, main="Scatterplot of wt vs disp")
hist(Weight, main="Histogram of wt")
boxplot(Weight, NOC, main="Boxplot of wt")
qqnorm(y=Height, distribution="norm", main="Scatterplot of wt vs disp")
hist(Height, main="Histogram of wt")
boxplot(Height, NOC, main="Boxplot of wt")
qqnorm(y=Age, distribution="norm", main="Scatterplot of wt vs disp")
hist(Age, main="Histogram of wt")
boxplot(Age, NOC, main="Boxplot of wt")










# for (col in colnames(olympics_mil)){
  
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
}


#for(i in 1:length(unique(a))){
# this.a <- unique(a)[i]
# unique(unique(as.vector(as.matrix(olympics_mil$col))))