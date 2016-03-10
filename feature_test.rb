require_relative './lib/oystercard'
require_relative './lib/station'
require_relative './lib/journey'
require_relative './lib/journey_log'

victoria = Station.new("Victoria", 1)
brixton = Station.new("Brixton", 1)
bank = Station.new("Bank", 1)


card = Oystercard.new

card.top_up(20)

card.touch_in(victoria)

card.touch_out(brixton)

p card.balance

card.touch_out(brixton)

p card.balance

card.touch_in(bank)

card.touch_in(bank)

p card.balance

p card.journey_history
