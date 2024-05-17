#Importing Data
library("readxl")
Steinberg=read_excel("G:\\Germany\\ihwb\\Steinberg.xlsx",sheet="R_Monthly")
View(Steinberg)
class(Steinberg)
str(Steinberg)

#Outliers
##########VISUALIZATION##################################################################################
#one
par(mfrow = c(1, 1))
boxplot(Steinberg)
boxplot(Steinberg, plot=FALSE)

#two
Steinberg_ts=ts(Steinberg)
hist(Steinberg_ts)

#three
qqnorm(Steinberg_ts)

#together
par(mfrow = c(1, 3))
hist(Steinberg_ts, main = "Histogram")
boxplot(Steinberg_ts, main = "Boxplot")
qqnorm(Steinberg_ts, main = "Normal Q-Q plot")

#Finding and Removing
outliers=which(Steinberg$R_Monthly %in% c(boxplot.stats(Steinberg$R_Monthly)$out))
length(outliers)

library("dplyr")

Steinberg_2=Steinberg %>%  filter(!row_number() %in% c(26, 22, 133, 145))
dim(Steinberg_2)

##########NUMERICAL METHOD######################################################################################
mean = mean(Steinberg_ts)
std = sd(Steinberg_ts)

# get threshold values for outliers
Tmin = mean-(3*std)
Tmax = mean+(3*std)

# find outlier
Steinberg_ts[which(Steinberg_ts < Tmin | Steinberg_ts > Tmax)]

# remove outlier
no_outliers=Steinberg_ts[which(Steinberg_ts > Tmin & Steinberg_ts < Tmax)]
length(no_outliers)


#Trend
##########STATISTICAL METHOD######################################################################################
library(Kendall)
MannKendall(Steinberg_ts)

#H0: There is no pattern in the data.
#H1: There is a trend in the data.

########VISUALIZATION########
par(mfrow = c(1, 1))
plot(Steinberg_ts)
lines(lowess(time(Steinberg_ts), Steinberg_ts), col='red')

Trend_Data=AirPassengers
plot(Trend_Data)
lines(lowess(time(Trend_Data), Trend_Data), col='red')


#checking the Trend with Mankendall
MannKendall(Trend_Data)

#Removing Trend
one=log(Trend_Data)
plot(one)
lines(lowess(time(one), one), col='red')
MannKendall(one)

two=diff(Trend_Data)
plot(two)
lines(lowess(time(two), two), col='red')
MannKendall(two)

#Seasonality & Cycling
##########NUMERICAL & VISUALIZATION######################################################################
#Decompose
library(tseries)
acf(Steinberg)
Steinberg_d = ts(Steinberg, start = c(2000, 1), frequency = 12)
decomposed_Steinberg = decompose(Steinberg_d)
print(decomposed_Steinberg)
plot(decomposed_Steinberg)
Final=Steinberg_d-decomposed_Steinberg$seasonal

