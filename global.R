# libs --------------------------------------------------------------------
library(shiny)
library(data.table)
library(ggplot2)
library(plotly)

# vars --------------------------------------------------------------------
dataFile = 'data/data.csv'

# load data ---------------------------------------------------------------
# if file is one day old
if(!file.exists(dataFile) ||
  as.Date(file.info(dataFile)$ctime) < Sys.Date()){
  print('download new data')
  download.file(url = "https://abwassermonitoring.at/cbe1/dl_natmon_01.csv"
                , destfile = dataFile)
}

dataRaw = fread(dataFile)

# tidy data ---------------------------------------------------------------
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