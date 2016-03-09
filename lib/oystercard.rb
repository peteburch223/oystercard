require_relative 'journey'

  class Oystercard

  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1
  MIN_ERROR = "You must have over £#{Oystercard::MIN_FARE} on your card"
  MAX_ERROR = "Exceeded £#{MAX_LIMIT} limit"



  attr_reader :balance, :journeys

  def initialize(journey_class: Journey)
    @balance = DEFAULT_BALANCE
    @journeys = []
    @journey_class = journey_class
  end

  def top_up(amount)
    raise MAX_ERROR if @balance + amount > MAX_LIMIT
    @balance += amount
  end

  def in_journey?
    !@journey.nil?
  end

  def touch_in(station)
    raise MIN_ERROR if @balance < MIN_FARE
    @journey = @journey_class.new
    @journey.add_station(:entry_station => station)
  end

  def touch_out(station)
    @journey.add_station(:exit_station => station)
     push_journey(@journey)
     @journey = nil
  end

  private


  def push_journey(journey)
    @balance -= MIN_FARE
    @journeys << @journey
  end



end
