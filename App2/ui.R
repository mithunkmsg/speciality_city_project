library(shiny)
library(dygraphs)
library(xts)
library(dplyr)
library(tidyr)
library(reshape2)
library(ggplot2)
speciality_wise<-readRDS("speciality_wise.rda")
city_wise<-readRDS("city_wise.rda")
speciality_wise[is.na(speciality_wise)]<-0
city_wise[is.na(city_wise)]<-0
df1<-melt(speciality_wise,id.vars = c("Date","Speciality","Category"))
df2<-melt(city_wise,id.vars = c("Date","City_Name","Category"))
df1$Date<-as.Date(df1$Date, format="%m/%d/%Y")
df2$Date<-as.Date(df2$Date, format="%m/%d/%Y")
df2$City_Name<-as.factor(df2$City_Name)
df2$Category<-as.factor(df2$Category)



shinyUI(
  pageWithSidebar(
    
    titlePanel(div(h4("TREND GRAPH FOR REQUEST, BOOKING, OPD AND IPD IN DIFFERENT MONTH", align = "center"), style = "color:red"),windowTitle = "Request Analysis"),

    sidebarPanel(
      h4(div("SPECIALITY_WISE PLOT",style="color:blue")),
      selectInput("Speciality","1. Please select a Speciality:",choices = levels(df1$Speciality),selected = "Renal Sciences"),
      radioButtons("Type","2. Please select a Type:",choices = levels(df1$Category),selected = "Domestic"),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      h4(div("CITY_WISE PLOT",style="color:blue")),
      selectInput("City","1. Please select a City:",choices = levels(df2$City_Name),selected = "Mumbai"),
      radioButtons("Category","2. Please select a Type:",choices = levels(df2$Category),selected = "Domestic"),
      br(),
      br(),
      br(),
      br(),
      br(),
      br()
      ),
    mainPanel(
      tabsetPanel(type="tab",
       tabPanel("Trend Graph",br(),
                h4(dygraphOutput("dygraph")),
                h4(textOutput("legendDivID"), title = "Legend", collapsible = F, width=2),
                br(),
                br(),
                
                h4(dygraphOutput("dygraph2"))),
       tabPanel("Analysis",fluidRow(
         splitLayout(cellWidths = c("50%", "50%"), plotOutput("plotgraph1"), plotOutput("plotgraph2"),plotOutput("plotgraph3"), plotOutput("plotgraph4"))
       ),
       fluidRow(
         splitLayout(cellWidths = c("50%", "50%"), verbatimTextOutput("text1"), verbatimTextOutput("text2"),verbatimTextOutput("text3"), verbatimTextOutput("text4"))
       ),
       fluidRow(
         splitLayout(cellWidths = c("50%", "50%"), plotOutput("plotgraph5"), plotOutput("plotgraph6"),plotOutput("plotgraph7"), plotOutput("plotgraph8"))
       ),
       fluidRow(
         splitLayout(cellWidths = c("50%", "50%"), verbatimTextOutput("text5"), verbatimTextOutput("text6"),verbatimTextOutput("text7"), verbatimTextOutput("text8"))
       )
       ),
       tabPanel("Bar Plot",h4(plotOutput("barplot")),
                br(),
                br(),br(),br(),br(),br(),br(),br(),br(),
                h4(plotOutput("barplot2"))),           
       tabPanel("Forecast",plotOutput("forcast")))
)
)
)
