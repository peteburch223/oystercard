require_relative 'station'
require_relative 'journey_log'

class Oystercard
  MAX_VALUE = 90
  MIN_VALUE = 1
  MAX_ERROR = "Limit of #{MAX_VALUE} exceeded"
  MIN_ERROR = "You have an insufficicent balance"

  attr_reader :balance

  def initialize(journey_log=JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
  end

  def top_up(cash)
    within_limit_check(cash)
    @balance += cash
  end

  def touch_in(station)
    deduct(@journey_log.current_journey.fare) if @journey_log.current_journey.in_progress?
    insufficient_funds_check
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
    deduct(@journey_log.current_journey.fare)
  end

  def journey_history
    @journey_log.journeys
  end

    private

      def within_limit_check(cash)
        raise MAX_ERROR if (balance + cash) > MAX_VALUE
      end

      def insufficient_funds_check
        raise MIN_ERROR if balance < MIN_VALUE
      end

      def deduct(fare)
        @balance -= fare
        @journey_log.store_journey
      end
end
