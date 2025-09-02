# Set seed for reproducibility
set.seed(123)

# Define the gift ideas
gift_ideas <- c(
  # Books-related gifts
  "📚 Bestseller novel - Check out [Amazon Books](https://www.amazon.com/books-used-books-textbooks/b?ie=UTF8&node=283155)",
  "🔖 Personalized bookmark - Get one on [Etsy](https://www.etsy.com/)",
  "💡 Reading lamp - Try [Ikea](https://www.ikea.com/) or [Target](https://www.target.com/)",
  "📦 Book subscription box - Explore [Book of the Month](https://www.bookofthemonth.com/)",
  "📖 Beautifully bound classic book - Find one at [Penguin Classics](https://www.penguinrandomhouse.com/series/LCB/penguin-classics-deluxe-editions)",
  
  # Plants-related gifts
  "🪴 Small indoor plant - Shop at [The Sill](https://www.thesill.com/)",
  "🌱 Plant care kit - Check out [Bloomscape](https://bloomscape.com/)",
  "🌸 Stylish plant pot - Available on [Wayfair](https://www.wayfair.com/)",
  "🌳 Bonsai tree - Get one from [Bonsai Boy](https://www.bonsaiboy.com/)",
  
  # Flowers
  "💐 Bouquet of fresh flowers - Order from [ProFlowers](https://www.proflowers.com/)",
  "🌷 Flower delivery subscription - Check [UrbanStems](https://urbanstems.com/)",
  
  # Lord of the Rings-related gifts
  "📖 LOTR collector's edition book - See [Tolkien Store](https://www.tolkien.co.uk/)",
  "💍 Replica of the One Ring - Shop at [Noble Collection](https://www.noblecollection.com/)",
  "☕ LOTR-themed mug - Browse [Etsy](https://www.etsy.com/)",
  "🗺️ Map of Middle-earth poster - Check [Redbubble](https://www.redbubble.com/)",
  
  # Food-related gifts
  "🍫 Gourmet chocolate box - Try [Godiva](https://www.godiva.com/)",
  "🍽️ Dinner at a fancy restaurant - Book via [OpenTable](https://www.opentable.com/)",
  "🧑‍🍳 DIY cooking kit - Explore [Blue Apron](https://www.blueapron.com/)",
  
  # Coffee-related gifts
  "☕ High-quality coffee grinder - Check [Baratza](https://www.baratza.com/)",
  "🫘 Premium coffee beans - Order from [Blue Bottle Coffee](https://bluebottlecoffee.com/)",
  "🍵 Stylish coffee mug - Available on [Anthropologie](https://www.anthropologie.com/)",
  "📦 Coffee subscription box - Check [Trade Coffee](https://www.drinktrade.com/)",
  
  # Expensive jewelry
  "💎 Diamond earrings - Shop at [Tiffany & Co.](https://www.tiffany.com/)",
  "📿 Gold necklace - Explore [Blue Nile](https://www.bluenile.com/)",
  "🛠️ Bracelet with personal engraving - Try [Etsy](https://www.etsy.com/)",
  
  # Pens and notebooks
  "🖋️ Luxury fountain pen - Shop at [Montblanc](https://www.montblanc.com/)",
  "📔 Leather-bound notebook - Check [Moleskine](https://www.moleskine.com/)",
  "🖍️ Set of colorful gel pens - Get them at [JetPens](https://www.jetpens.com/)",
  
  # Winter warmth gifts
  "🛋️ Cozy blanket - Check [Brooklinen](https://www.brooklinen.com/)",
  "🧣 Stylish winter scarf - Shop at [Nordstrom](https://www.nordstrom.com/)",
  "🧦 Thermal socks - Try [Smartwool](https://www.smartwool.com/)",
  "🔥 Heated mug - Available on [Amazon](https://www.amazon.com/)",
  "🧤 Warm gloves - Check [REI](https://www.rei.com/)"
)

# Create an empty list to store selected gifts
selected_gifts <- c()

# Loop to allow multiple selections
repeat {
  choice <- menu(gift_ideas, title = "Select a gift for your lovely gf (0 to finish):")
  if (choice == 0) break
  selected_gifts <- c(selected_gifts, gift_ideas[choice])
}

# Print the final selection
cat("Your selected gifts:\n", paste(selected_gifts, collapse = "\n"), "\n")
