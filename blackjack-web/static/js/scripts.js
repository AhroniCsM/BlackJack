const dealBtn = document.getElementById("deal-btn");
const hitBtn = document.getElementById("hit-btn");
const standBtn = document.getElementById("stand-btn");
const playerHandDiv = document.getElementById("player-hand");
const dealerHandDiv = document.getElementById("dealer-hand");
const playerScore = document.getElementById("player-score");
const result = document.getElementById("result");

let playerHand = [];
let dealerHand = [];

dealBtn.addEventListener("click", () => {
    fetch("/deal", { method: "POST" })
        .then(res => res.json())
        .then(data => {
            playerHand = data.player_hand;
            dealerHand = data.dealer_hand;
            playerHandDiv.innerHTML = renderHand(playerHand);
            dealerHandDiv.innerHTML = renderHand(dealerHand);
            playerScore.textContent = `Your Score: ${data.player_value}`;
            hitBtn.disabled = false;
            standBtn.disabled = false;
            dealBtn.disabled = true;
        });
});

hitBtn.addEventListener("click", () => {
    fetch("/hit", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ player_hand: playerHand }),
    })
        .then(res => res.json())
        .then(data => {
            playerHand = data.player_hand;
            playerHandDiv.innerHTML = renderHand(playerHand);
            playerScore.textContent = `Your Score: ${data.player_value}`;
            if (data.bust) {
                result.textContent = "Bust! Dealer Wins!";
                hitBtn.disabled = true;
                standBtn.disabled = true;
                dealBtn.disabled = false;
            }
        });
});

standBtn.addEventListener("click", () => {
    fetch("/stand", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ player_hand: playerHand, dealer_hand: dealerHand }),
    })
        .then(res => res.json())
        .then(data => {
            dealerHandDiv.innerHTML = renderHand(data.dealer_hand);
            result.textContent = `Winner: ${data.winner}`;
            hitBtn.disabled = true;
            standBtn.disabled = true;
            dealBtn.disabled = false;
        });
});

function renderHand(hand) {
    return hand
        .map(card => `<img src="/static/images/cards/${card}.png" class="card" alt="${card}">`)
        .join("");
}
