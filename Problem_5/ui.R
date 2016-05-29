
shinyUI(fluidPage( 
  titlePanel("Sentiment Analysis on US Presidential Elections 2016"), #Title
  sidebarLayout(
    sidebarPanel(
      selectInput("candidate", "Choose your candidate",choices = c("Hillary Clinton", "Bernie Sander","Donald Trump", "Marco Rubio", "Ted Cruz", "John Kasich"), selected = 1),width=3),
    
    mainPanel(
      conditionalPanel(
        condition = "input.candidate == 'Hillary Clinton'",
        splitLayout(cellWidths = c("30%", "70%"), plotOutput("clinton_plot"), plotOutput("cum_clinton_plot")),
        dataTableOutput('clinton_table')
      ),
      
      conditionalPanel(
        condition = "input.candidate == 'Bernie Sander'",
        splitLayout(cellWidths = c("30%", "70%"), plotOutput("sander_plot"), plotOutput("cum_sander_plot")),
        dataTableOutput('sander_table')
      ),
      
      conditionalPanel(
        condition = "input.candidate == 'Donald Trump'",
        splitLayout(cellWidths = c("30%", "70%"), plotOutput("trump_plot"), plotOutput("cum_trump_plot")),
        dataTableOutput('trump_table')
      ),
      
      conditionalPanel(
        condition = "input.candidate == 'Marco Rubio'",
        splitLayout(cellWidths = c("30%", "70%"), plotOutput("rubio_plot"), plotOutput("cum_rubio_plot")),
        dataTableOutput('rubio_table')
      ),
      
      conditionalPanel(
        condition = "input.candidate == 'Ted Cruz'",
        splitLayout(cellWidths = c("30%", "70%"), plotOutput("cruz_plot"), plotOutput("cum_cruz_plot")),
        dataTableOutput('cruz_table')
      ),
      
      conditionalPanel(
        condition = "input.candidate == 'John Kasich'",
        splitLayout(cellWidths = c("30%", "70%"), plotOutput("kasich_plot"), plotOutput("cum_kasich_plot")),
        dataTableOutput('kasich_table') #Here I show the users and the sentiment
      )
    )
  )
))