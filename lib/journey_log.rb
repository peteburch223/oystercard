class JourneyLog


  def initialize(journey_class=Journey)
    @journey_history = []
    @journey_class = journey_class
  end

  def start(station)
     @journey.entry_st(station)
  end

  def finish(station)
    @journey.exit_st(station)
    @journey_history << @journey
  end

  def current_journey
    @journey ||= @journey_class.new
  end

  def journeys
    @journey_history
  end

end
