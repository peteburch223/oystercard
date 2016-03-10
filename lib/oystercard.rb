require_relative 'station'
require_relative 'journey'

class Oystercard
  MAX_VALUE = 90
  MIN_VALUE = 1
  MAX_ERROR = "Limit of #{MAX_VALUE} exceeded"
  MIN_ERROR = "You have an insufficicent balance"
  PENALTY_FARE = Journey::PENALTY_FARE
  MIN_FARE = Journey::MIN_FARE

  attr_reader :balance, :journey_history


  def initialize(journey_class=Journey)
    @balance = 0
    @journey_history = []
    @journey_class = journey_class
  end

  def top_up(cash)
    within_limit(cash)
    @balance += cash
  end

  def touch_in(station)
     insufficient_funds
     deduct(@journey.fare) if !@journey.nil?
     @journey = @journey_class.new
     @journey.entry_st(station)
  end

  def touch_out(station)
    @journey = @journey_class.new if @journey.nil?
    @journey.exit_st(station)
    deduct(@journey.fare)
    record_journey
    @journey = nil
  end


    private
    def within_limit(cash)
      raise MAX_ERROR if (balance + cash) > MAX_VALUE
    end

    def insufficient_funds
      raise MIN_ERROR if balance < MIN_VALUE
    end

    def deduct(fare)
      @balance -= fare
    end

    def record_journey
      @journey_history << @journey
    end

end
