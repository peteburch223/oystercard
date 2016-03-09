  class Oystercard

  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1
  MIN_ERROR = "You must have over £#{Oystercard::MIN_FARE} on your card"
  MAX_ERROR = "Exceeded £#{MAX_LIMIT} limit"



  attr_reader :balance, :journeys

  def initialize
    @balance = DEFAULT_BALANCE
    @journeys = []
    @journey = {}
  end

  def top_up(amount)
    raise MAX_ERROR if @balance + amount > MAX_LIMIT
    @balance += amount
  end

  def in_journey?
    !@journey.empty?
  end

  def touch_in(station)

    raise MIN_ERROR if @balance < MIN_FARE
    @journey[:entry_station] = station
  end

  def touch_out(station)
     deduct(MIN_FARE)
     @journey[:exit_station] = station
     @journeys << @journey
     @journey = {}
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
