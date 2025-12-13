# Correlation :
View(houseprice)

cor(houseprice$Price, houseprice$`Lot Size`)
cor(houseprice$Price, houseprice$`Living Area`)

# pie chart using ggplot
library(ggplot2)

ggplot(data = houseprice) + # create a plot and its axes
  geom_bar(aes(x = Fireplace)) + 
  coord_polar()

# frequency table
freq <- as.data.frame(table(houseprice$Fireplace))
freq  

# Creating Bar Chart
ggplot(data = freq, aes(x = Var1 , y = Freq, fill = Var1)) +
  geom_bar(stat = 'identity')
  
# Creating Pie Chart
ggplot(data = freq, aes(x = "" , y = Freq, fill = Var1)) +
  geom_bar(stat = 'identity') +
  coord_polar(theta = "y") + 
  theme_void() + 
  labs(title = "Fireplaces") 

# 
pie(table(houseprice$Fireplace))
  