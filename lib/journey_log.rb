class JourneyLog

  def initialize(journey_class=Journey)
    @journey_history = []
    @journey_class = journey_class
  end
  def start
  end

  def finish
  end

  def current_journey
    @journey ||= @journey_class.new
  end

  def journeys
  end

end
