# libs --------------------------------------------------------------------
library(shiny)
library(data.table)
library(ggplot2)

# load data ---------------------------------------------------------------
# init load data
if(FALSE){
  download.file(url = "https://abwassermonitoring.at/cbe1/dl_natmon_01.csv"
                , destfile = 'data/data.csv')
}

dataRaw = fread('data/data.csv')
# tidy data
scale = 10000
data = dataRaw[,.(  Datum = as.Date(Datum)
                    , Humansignal = `gemittelte kumulierte Faelle der letzten 7 Tage aus den Humantestungen`
                    , Abwassersignal = as.integer(`Gesamtvirenfracht [Genkopien pro Tag * 10^6]`/scale)
)]
dataPlot = melt(data = data
     , id.vars = c('Datum')
     , variable.name = 'variable'
     , value.name = 'value'
     )

ggplot(data = data, aes(x=Datum)) +
  geom_line( aes(y=Abwassersignal/scale), color = 'orange') + 
  geom_line( aes(y=Humansignal), color = 'blue') +
  scale_y_continuous(
    "Abwassersignal", 
    sec.axis = sec_axis(~ . * scale, name = "Humansignal")
  ) +
  theme(axis.text.y=element_blank(),  #remove y axis labels
        axis.ticks.y=element_blank()  #remove y axis ticks
  )

ggplot(dataPlot, aes(Datum, value, colour = variable)) +
  geom_line() +
  theme(axis.title.y = element_blank(), 
        axis.text.y=element_blank(),  #remove y axis labels
        axis.ticks.y=element_blank(),  #remove y axis ticks
        legend.title = element_blank()
  )


