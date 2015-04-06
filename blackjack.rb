# 1. 得到一副牌,并洗牌
# 2. 给玩家发一张牌，给庄家发一张牌；再给玩家发一张牌，再给庄家发一张牌。算牌
#    如果玩家有一张A一张J（即“blackjack")，
#    而此时庄家没有blackjack，则玩家赢。反之，庄家赢。
#    如果都是blackjack，则为平局
# 3. 如果刚开始没人有blackjack，玩家选择要牌(hit)或者停牌(stay)：
#    a)如果选择要牌，给玩家发一张牌：
#      如果玩家的点数小于等于21点，还可以继续选择要牌或停牌；
#      如果玩家的点数大于21点，玩家bust，庄家赢！
#    b)如果选择停牌，保存玩家的总点数，轮到庄家。
# 4. 如果庄家的点数小于17，则必须要牌；如果庄家的点数大于等于17，则必须停牌。
#    当庄家的点数大于21点时，庄家bust，玩家赢
# 5. 如果玩家和庄家都没有bust，最后比较庄家和玩家的点数，点数大者赢，点数相同则为平局。
require "pry"

def prompt(msg)
  puts "=> " + msg
end
def say_result(msg)
  puts "===== " + msg + " ====="
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
    if total > 21
      total -= 10
    end
  end
  return total
end

def show_cards(player_cards, dealer_cards, player_total, dealer_total)
  prompt "You have: #{player_cards}, for a total of #{player_total}"
  prompt "Dealer has: #{dealer_cards}, for a total of #{dealer_total}"
end

# 1
suits = ['H', 'S', 'C', 'D']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
deck = suits.product(cards)
deck.shuffle!

# 2
player_cards = []
dealer_cards = []
player_cards << deal_card(deck)
dealer_cards << deal_card(deck)
player_cards << deal_card(deck)
dealer_cards << deal_card(deck)
# p player_cards 
# p dealer_cards
c = 0
dealer_total = 0
player_total = calculate_total(player_cards)
dealer_total = calculate_total(dealer_cards)
show_cards(player_cards,dealer_cards,player_total,dealer_total)
if player_total == 21 and dealer_total == 21
  say_result "It's a tie"
  exit
elsif player_total == 21
  say_result "Blackjack! You won!"
  exit
elsif dealer_total == 21
  say_result "Blackjack! Dealer won!"
  exit
end

# 3
# player turn
while player_total < 21 
  begin
    print "Please choose: 1)Hit 2)Stand : "
    choose = gets.chomp.to_i
  end while choose != 1 and choose != 2 
    if choose == 1
      player_cards << deal_card(deck)
      prompt "Your cards: #{player_cards} "
    else
      break
    end
  player_total = calculate_total(player_cards)
  prompt "Your total: #{player_total}"
end
# p player_total
if player_total > 21
  say_result "Sorry, you busted. You lose!"
  exit
end

# dealer turn 
while dealer_total < 21
  if dealer_total < 17
    dealer_cards << deal_card(deck)
    dealer_total = calculate_total(dealer_cards)
    next
  elsif dealer_total >=17 and dealer_total <= 21
    break
  else
    say_result "Congratulation! Dealer busted. You won!"
    exit
  end
end

# compare
if player_total == dealer_total
  say_result "It's a tie"
elsif player_total > dealer_total
  say_result "Congratulation, you won! Your total: #{player_total}, dealer total: #{dealer_total}"
else
  say_result "Sorry, dealer won! Your total: #{player_total}, dealer total: #{dealer_total}"
end







