# Define card values and suits
values=("2" "3" "4" "5" "6" "7" "8" "9" "10" "J" "Q" "K" "A")
suits=("hearts" "diamonds" "clubs" "spades")
suit_images=("heart.png" "diamonds.png" "club.png" "spade.png")

# Create the directory for cards
mkdir -p static/images/cards

# Generate cards with centered suit and numbers in corners
for value in "${values[@]}"; do
  for i in "${!suits[@]}"; do
    suit="${suits[i]}"
    suit_image="static/images/suits/${suit_images[i]}"
    card_image="static/images/cards/${value}_of_${suit}.png"

    # Create card with white background and overlay text and suit image
    magick -size 270x410 xc:white \
      -gravity northwest -fill black -pointsize 44 -annotate +35+30 "${value}" \
      -gravity southeast -annotate +35+30 "${value}" \
      -gravity center -draw "image over -10,-20 170,170 '${suit_image}'" \
      "$card_image"
  done
done
