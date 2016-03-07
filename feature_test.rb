require './lib/oystercard.rb'

card = Oystercard.new
puts card.balance
card.top_up(40)
puts card.balance
card.deduct(20)
puts card.balance

# go on a journey
puts card.in_journey?
card.touch_in
puts card.in_journey?
card.touch_out
puts card.in_journey?
