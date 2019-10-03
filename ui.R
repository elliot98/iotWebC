shinyUI(
  pageWithSidebar(
    headerPanel("Climactic Averages"),
    sidebarPanel(
      h3("Average Temperature (C) :"), h2(textOutput("temp")),
      h3("Average Pressure :"), h2(textOutput("pres")),
      h4("Number of clusters of maximum probability :", textOutput("count")),
      h4("Maximum datapoints in the selected cluster(s) : ", textOutput("max"))
          ),
    mainPanel(imageOutput("cluPlot"),htmlOutput("tag"), imageOutput("cluPlot2"))
  )
)