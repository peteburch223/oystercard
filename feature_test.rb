require_relative './lib/oystercard'
require_relative './lib/station'
require_relative './lib/journey'
require_relative './lib/journey_log'

card = Oystercard.new

card.top_up(20)

card.touch_in("Victoria")

card.touch_out("Brixton")

p card.balance

card.touch_out("Brixton")

p card.balance

card.touch_in("Bank")

card.touch_in("Bank")

p card.balance
