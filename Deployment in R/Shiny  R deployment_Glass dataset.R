library(shiny)
ui <- fluidPage(
  titlePanel("Prediction"),
  sidebarLayout(
    sidebarPanel(
      numericInput("num","Enter RI",1),
      numericInput("num1","Enter Na  ",1),
      numericInput("num2","Enter Mg  ",1),
      numericInput("num3","Enter Al ",1),
      numericInput("num4","ENTER Si",1),
      numericInput("num5","ENTER k ",1),
      numericInput("num6","ENTER Ca ",1),
      numericInput("num7","ENTER Ba ",1),
      numericInput("num8","ENTER Fe",1)
    ),
    mainPanel(
      tableOutput("distplot")
      
    )
  )
)
server <- function(input, output) {
  output$distplot <- renderTable({
    
    glass <- read.csv("glass.csv")
    
    set.seed(123)
    glass_test=glass[-split,]
    glass_trainl=glass_train[,10]
    glass_testl=glass_test[,10]
    glass_train=glass_train[,-10]
    glass_test=glass_test[,-10]
    library(class)
    nw=data.frame(RI=input$num,Na=input$num1,Mg=input$num2,Al=input$num3,Si=input$num4,
                  K=input$num5,Ca=input$num6,Ba=input$num7,Fe=input$num8)
    pred=knn(glass[,-10],nw,cl=glass[,10],k=4)
    pred
  })
  
}

shinyApp(ui = ui, server = server)

