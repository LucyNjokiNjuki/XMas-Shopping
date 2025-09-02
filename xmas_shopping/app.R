library(shiny)
library(DT)
library(shinythemes)

# Define grouped gift ideas as a data frame
gift_data <- data.frame(
  Category = c(
    rep("Books", 5),
    rep("Plants", 4),
    rep("Flowers", 2),
    rep("LOTR", 4),
    rep("Food", 3),
    rep("Coffee", 4),
    rep("Jewelry", 3),
    rep("Stationery", 3),
    rep("Winter Warmth", 5)
  ),
  Gift = c(
    "📚 Bestseller novel", "🔖 Personalized bookmark", "💡 Reading lamp", "📦 Book subscription box", "📖 Beautifully bound classic book",
    "🪴 Small indoor plant", "🌱 Plant care kit", "🌸 Stylish plant pot", "🌳 Bonsai tree",
    "💐 Bouquet of fresh flowers", "🌷 Flower delivery subscription",
    "📖 LOTR collector's edition book", "💍 Replica of the One Ring", "☕ LOTR-themed mug", "🗺️ Map of Middle-earth poster",
    "🍫 Gourmet chocolate box", "🍽️ Dinner at a fancy restaurant", "🧑‍🍳 DIY cooking kit",
    "☕ High-quality coffee grinder", "🫘 Premium coffee beans", "🍵 Stylish coffee mug", "📦 Coffee subscription box",
    "💎 Diamond earrings", "📿 Gold necklace", "🛠️ Bracelet with personal engraving",
    "🖋️ Luxury fountain pen", "📔 Leather-bound notebook", "🖍️ Set of colorful gel pens",
    "🛋️ Cozy blanket", "🧣 Stylish winter scarf", "🧦 Thermal socks", "🔥 Heated mug", "🧤 Warm gloves"
  ),
  Link = c(
    "https://www.amazon.com/books-used-books-textbooks/b?ie=UTF8&node=283155",
    "https://www.etsy.com/",
    "https://www.ikea.com/",
    "https://www.bookofthemonth.com/",
    "https://www.penguinrandomhouse.com/series/LCB/penguin-classics-deluxe-editions",
    "https://www.thesill.com/",
    "https://www.houseplant.co.uk/",
    "https://www.wayfair.com/",
    "https://www.patchplants.com/",
    "https://www.prestigeflowers.co.uk/",
    "https://www.eflorist.co.uk/",
    "https://www.tolkien.co.uk/",
    "https://www.noblecollection.com/",
    "https://www.etsy.com/",
    "https://www.redbubble.com/",
    "https://www.godiva.com/",
    "https://www.opentable.com/",
    "https://www.blueapron.com/",
    "https://www.baratza.com/",
    "https://bluebottlecoffee.com/",
    "https://www.anthropologie.com/",
    "https://www.drinktrade.com/",
    "https://www.tiffany.com/",
    "https://www.glamira.co.uk/",
    "https://www.etsy.com/",
    "https://www.montblanc.com/",
    "https://www.moleskine.com/",
    "https://www.jetpens.com/",
    "https://homemaker-bedding.co.uk/",
    "https://www.nordstrom.com/",
    "https://www.smartwool.com/",
    "https://www.amazon.com/",
    "https://www.rei.com/"
  ),
  stringsAsFactors = FALSE
)

# UI
ui <- fluidPage(
  theme = shinytheme("paper"),
  tags$head(
    tags$style(HTML("
      body {
        font-family: 'Comic Sans MS', cursive, sans-serif;
      }
      .bought {
        text-decoration: line-through;
        color: #aaa;
      }
    "))
  ),
  
  titlePanel("🎁 Gift Selector for My Lovely Partner ❤️"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("category", "Choose a category:", choices = unique(gift_data$Category)),
      uiOutput("gift_selector"),
      numericInput("price", "Estimated price (£):", value = 0, min = 0),
      checkboxInput("mark_bought", "Mark as bought", FALSE),
      actionButton("add_gift", "Add to List"),
      hr(),
      textInput("custom_item", "Add a custom item:"),
      textInput("custom_link", "Link to buy (optional):"),
      numericInput("custom_price", "Estimated price (£):", value = 0, min = 0),
      actionButton("add_custom", "Add Custom Item"),
      hr(),
      actionButton("remove_selected", "❌ Remove Selected"),
      downloadButton("download_list", "📥 Download List"),
      hr(),
      h4("💸 Total Budget:"),
      textOutput("total_budget")
    ),
    
    mainPanel(
      fluidRow(
        column(6,
               wellPanel(
                 h4("🛍️ Your Shopping List"),
                 DTOutput("gift_table")
               ),
               wellPanel(
                 h4("⏳ Countdown to Gifting Day"),
                 textOutput("countdown")
               )
        ),
        column(6,
               wellPanel(
                 h4("📊 Spending by Category"),
                 plotOutput("budget_pie", height = "300px")
               ),
               wellPanel(
                 h4("💸 Total Budget"),
                 textOutput("total_budget")
               )
        )
      )
    )
  )
)

# Server
server <- function(input, output, session) {
  gift_list <- reactiveVal(data.frame(
    Gift = character(), Link = character(), Bought = logical(), Price = numeric(), stringsAsFactors = FALSE
  ))
  
  output$gift_selector <- renderUI({
    filtered <- gift_data[gift_data$Category == input$category, ]
    selectInput("gift_choice", "Select a gift:", choices = setNames(filtered$Link, filtered$Gift))
  })
  
  observeEvent(input$add_gift, {
    req(input$gift_choice)
    gift_name <- gift_data$Gift[gift_data$Link == input$gift_choice]
    new_row <- data.frame(Gift = gift_name, Link = input$gift_choice, Bought = input$mark_bought, Price = input$price)
    gift_list(rbind(gift_list(), new_row))
  })
  
  observeEvent(input$add_custom, {
    req(input$custom_item)
    new_row <- data.frame(Gift = input$custom_item, Link = input$custom_link, Bought = FALSE, Price = input$custom_price)
    gift_list(rbind(gift_list(), new_row))
    updateTextInput(session, "custom_item", value = "")
    updateTextInput(session, "custom_link", value = "")
    updateNumericInput(session, "custom_price", value = 0)
  })
  
  observeEvent(input$remove_selected, {
    selected <- input$gift_table_rows_selected
    if (length(selected) > 0) {
      updated <- gift_list()[-selected, ]
      gift_list(updated)
    }
  })
  
  output$gift_table <- renderDT({
    datatable(
      gift_list(),
      escape = FALSE,
      rownames = FALSE,
      selection = "multiple",
      options = list(pageLength = 10),
      callback = JS("
        table.rows().every(function(){
          var data = this.data();
          if (data[2] === true) {
            $(this.node()).addClass('bought');
          }
        });
      ")
    )
  })
  
  output$total_budget <- renderText({
    total <- sum(gift_list()$Price)
    paste0("£", format(total, nsmall = 2))
  })
  
  output$countdown <- renderText({
    gifting_day <- as.Date("2025-12-25")
    today <- Sys.Date()
    days_left <- as.numeric(gifting_day - today)
    paste(days_left, "days left until gifting day 🎄")
  })
  
  output$budget_pie <- renderPlot({
    df <- gift_list()
    if (nrow(df) == 0) return(NULL)
    df$Category <- gift_data$Category[match(df$Gift, gift_data$Gift)]
    df$Category[is.na(df$Category)] <- "Custom"
    pie_data <- aggregate(Price ~ Category, data = df, sum)
    pie(pie_data$Price, labels = paste0(pie_data$Category, ": £", pie_data$Price),
        col = rainbow(length(pie_data$Category)), main = "Spending by Category")
  })
  
  output$download_list <- downloadHandler(
    filename = function() {
      paste("gift_list_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(gift_list(), file, row.names = FALSE)
    }
  )
}

# Run the app
shinyApp(ui, server)