class Journey

  attr_reader :entry_station, :exit_station

  PENALTY_FARE = 6
  MIN_FARE = 1

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def entry_st(station)
    @entry_station = station
  end

  def exit_st(station)
    @exit_station = station
  end

  def in_progress?
    @entry_station.nil? ^ @exit_station.nil?
  end


  def fare
    if in_progress?
      PENALTY_FARE
    elsif @entry_station.nil? && @exit_station.nil?
      0
    else
      MIN_FARE
    end
  end

end
