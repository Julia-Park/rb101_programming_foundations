Goal: Get as close to 21 as possible without going over.
- if you go over, it's a bust

Set up:  
Dealer and Player are each dealt 2 cards
- Player can see their 2 cards, but only one of the Dealer's
- All cards face value; face cards worth 10
- Ace is worth 1 or 11, depending on the value of the rest of the cards
  - 11 if sum of other cards (not Ace) <= 10 
  - 1 if sum of other cards > 10
  - What happens if there are two Aces?
    - Then one Ace is definitely value == 1; other depends on other cards

Player turn
Can hit or stay
hit - player asks for another card
- player can hit as many times as they want
turn is over when player stays
player loses if they bust

Dealer's turn
hit until the total is at least 17
player automatically wins if deale busts

Compare
Dealer or player with highest sum wins.

1. Initialize deck
2. Deal cards to Player and Dealer
3. Player turn - choose between hit and stay
  - Repeat until bust or stay
    - If bust, round over.  Dealer wins.
4. Dealer turn - choose between hit (if sum < 17) and stay
  - Repeat until bust or stay
  - If bust, round over.  Player wins.
5. Determine winner
  - Dealer/Player with highest sum wins.