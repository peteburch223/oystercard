class Journey

  MIN_FARE = 1
  PENALTY_FARE = 6

  attr_reader :trip

  def initialize
    @trip = {}
  end

  def add_station(station)
    trip.merge!(station)
  end

  def fare
    trip.length == 2 ? MIN_FARE : PENALTY_FARE
  end

end
