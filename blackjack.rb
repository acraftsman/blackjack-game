# 1. get a deck and shuffle it
# 2. deal a card to player, deal a card to dealer. Once again.
#    calculate total. There are three situations:
#    1) If player has a "Ace" and a "Jack", however dealer doesn't hit blackjack at this point. Player won!  
#    2) Conversely, dealer won!
#    3) If they all hit the blackjack. It's a tie.
# 3. If none of the them occurred in step 2, player should choose to hit or stay.
#    1) If player choose to hit, deal a card to it. and then,
#       If player's total points less than or equal to UPPER_LIMIT_POINT, player should choose to hit or stay once more.
#       If player's total points greater than UPPER_LIMIT_POINT, player busted. Dealer won!
#    2) If player choose to stay, save the total point of player's, turn to dealer.
# 4. If dealer's total points less than 17, it must hit. 
#    If dealer's total points great than or equal to 17, it must stay.
#    If dealer's total points great than UPPER_LIMIT_POINT, it busted. Player won!
# 5. If they all have not busted finnally, we should compare the total points. The greater one win the game. 
#    If their points are equivalent, it is a tie.
require "pry"

def prompt(msg)
  puts "=> #{msg}"
end
def say_result(msg)
  puts "===== #{msg} ====="
end
def deal_card(deck) #[["H", "2"], ["H", "3"], ...]
  deck.pop
end

def calculate_total(cards)
  cards_arr = cards.map{ |arr| arr[1] }
  total = 0
  cards_arr.each do |val|
    if val.to_i == 0
      total += 10
    else
      total += val.to_i 
    end
  end  
  a_arr = cards_arr.select{ |e| e == 'A'}
  a_arr.each do
    total += 1
    if total > UPPER_LIMIT_POINT
      total -= 10
    end
  end
  return total
end

# 1
SUITS = ['H', 'S', 'C', 'D']
CARDS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
deck = SUITS.product(CARDS)
deck.shuffle!
UPPER_LIMIT_POINT = 21

# 2
player_cards = []
dealer_cards = []
2.times do
  player_cards << deal_card(deck)
  dealer_cards << deal_card(deck)
end
c = 0
dealer_total = 0
player_total = calculate_total(player_cards)
dealer_total = calculate_total(dealer_cards)
prompt "You have: #{player_cards}, for a total of #{player_total}"
prompt "Dealer has: #{dealer_cards[1]} and ...}"
if player_total == UPPER_LIMIT_POINT and dealer_total == UPPER_LIMIT_POINT
  say_result "It's a tie (Your total: #{player_total}, dealer total: #{dealer_total})"
  exit
elsif player_total == UPPER_LIMIT_POINT
  say_result "Blackjack! You won! (Your total: #{player_total}, dealer total: #{dealer_total})"
  exit
elsif dealer_total == UPPER_LIMIT_POINT
  say_result "Blackjack! Dealer won! (Your total: #{player_total}, dealer total: #{dealer_total})"
  exit
end

# 3
# player turn
while player_total < UPPER_LIMIT_POINT 
  begin
    print "Please choose: 1)Hit 2)Stand : "
    choose = gets.chomp.to_i
  end until choose == 1 || choose == 2 
    if choose == 1
      player_cards << deal_card(deck)
      prompt "Your cards: #{player_cards} "
    else
      break
    end
  player_total = calculate_total(player_cards)
  prompt "Your total: #{player_total} "
end
# p player_total
if player_total > UPPER_LIMIT_POINT
  say_result "Sorry, you busted. You lose! (Your total: #{player_total}, dealer total: #{dealer_total})"
  exit
end

# dealer turn 
while dealer_total < UPPER_LIMIT_POINT
  if dealer_total < 17
    dealer_cards << deal_card(deck)
    dealer_total = calculate_total(dealer_cards)
    next
  elsif dealer_total >=17 && dealer_total <= UPPER_LIMIT_POINT
    break
  else
    say_result "Congratulation! Dealer busted. You won! (Your total: #{player_total}; Dealer total: #{dealer_total})"
    exit
  end
end
if dealer_total > UPPER_LIMIT_POINT
  say_result "Congratulation, dealer busted. You won! (Your total: #{player_total}, dealer total: #{dealer_total})"
  exit
end

# compare
if player_total == dealer_total
  say_result "It's a tie"
elsif player_total > dealer_total
  say_result "Congratulation, you won! (Your total: #{player_total}, dealer total: #{dealer_total})"
else
  say_result "Sorry, dealer won! (Your total: #{player_total}, dealer total: #{dealer_total})"
end







