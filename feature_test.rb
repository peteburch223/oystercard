require './lib/oystercard.rb'

card = Oystercard.new
puts card.balance
card.top_up(40)
puts card.balance
card.deduct(20)
puts card.balance
