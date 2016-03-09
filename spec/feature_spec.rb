require 'oystercard'
require 'station'
describe 'Feature Test' do
pending do
card = Oystercard.new
card.top_up(10)
puts "Card balance after top-up: #{card.balance}"
puts "In journey before touching in: #{card.in_journey?}"
card.touch_in('aldgate')
puts "In journey after touching in: #{card.in_journey?}"
card.touch_out('brixton')
puts "In journey after touching out: #{card.in_journey?}"
puts "Journeys : #{card.journeys}"
puts "Balance after journey #{card.balance}"
# card.touch_out('Shoreditch')
# puts "Journeys after touching out without touching in : #{card.journeys}"
# puts "Balance after touching out twice without touching in : #{card.balance}"
# card.touch_in('ricky')
# card.touch_in('chorleywood')
# puts "Journeys after touching in twice : #{card.journeys}"
# puts "Balance after touching in twice #{card.balance}"
end
end
