from flask import Flask, render_template, request, jsonify
import random

# Initialize Flask application
app = Flask(__name__)

# Define card values and deck
card_values = {
    '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9,
    '10': 10, 'J': 10, 'Q': 10, 'K': 10, 'A': 11  # Ace is 11 by default
}
suits = ['hearts', 'diamonds', 'clubs', 'spades']
deck = [f"{value}_of_{suit}" for value in card_values.keys() for suit in suits]

# Shuffle deck
def shuffle_deck():
    random.shuffle(deck)

# Calculate hand value
def calculate_hand(hand):
    value = sum(card_values[card.split('_')[0]] for card in hand)
    aces = sum(1 for card in hand if card.split('_')[0] == 'A')
    while value > 21 and aces:
        value -= 10
        aces -= 1
    return value

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/deal', methods=['POST'])
def deal():
    global deck
    shuffle_deck()
    player_hand = [deck.pop(), deck.pop()]
    dealer_hand = [deck.pop(), deck.pop()]
    return jsonify({
        "player_hand": player_hand,
        "dealer_hand": dealer_hand[:1],  # Hide one dealer card
        "player_value": calculate_hand(player_hand)
    })

@app.route('/hit', methods=['POST'])
def hit():
    player_hand = request.json.get('player_hand', [])
    player_hand.append(deck.pop())
    return jsonify({
        "player_hand": player_hand,
        "player_value": calculate_hand(player_hand),
        "bust": calculate_hand(player_hand) > 21
    })

@app.route('/stand', methods=['POST'])
def stand():
    player_hand = request.json['player_hand']
    dealer_hand = request.json['dealer_hand']
    while calculate_hand(dealer_hand) < 17:
        dealer_hand.append(deck.pop())
    player_value = calculate_hand(player_hand)
    dealer_value = calculate_hand(dealer_hand)
    winner = (
        "Player" if dealer_value > 21 or player_value > dealer_value else
        "Dealer" if player_value < dealer_value else
        "Tie"
    )
    return jsonify({
        "dealer_hand": dealer_hand,
        "dealer_value": dealer_value,
        "winner": winner
    })

if __name__ == '__main__':
    # Ensure the app runs on port 5003 with host 0.0.0.0
    app.run(host='0.0.0.0', port=5003, debug=False)
