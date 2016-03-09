require 'journey'

class JourneyLog

  attr_reader :journeys

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station)
    @journey.add_station(:entry_station => station)
  end

  def finish(station)
    @journey.add_station(:exit_station => station)
  end

  def current_journey
    @journey ||= @journey_class.new
  end

  def commit
    @journeys << @journey
    @journey = nil
  end

end
