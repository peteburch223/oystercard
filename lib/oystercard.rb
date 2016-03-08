class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journeys

  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1


  def initialize
    @balance = DEFAULT_BALANCE
    @entry_station = []
    @exit_station = []
    @journeys = Hash.new
  end

  def top_up(amount)
    raise "Exceeded £#{MAX_LIMIT} limit" if max_reached?(amount)
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise "You must have over £#{Oystercard::MIN_FARE} on your card" if min_reached?
    @entry_staton = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @exit_station = station
    @journeys['Journey'] = [@entry_staton,@exit_station]
    @entry_station = nil
  end

  def zero_balance?
    start_balance
  end

  private

  def start_balance
    @balance == DEFAULT_BALANCE
  end

  def max_reached?(amount)
    @balance + amount > MAX_LIMIT
  end

  def min_reached?
    @balance < MIN_FARE
  end

  def deduct(fare)
    @balance -= fare
  end

end
