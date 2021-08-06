class Journey
  attr_reader :entry_station, :exit_station

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def end_journey(station)
    @exit_station = station
    { :entry_station => @entry_station, :exit_station => @exit_station }
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

  def complete?
    @entry_station != nil && exit_station != nil
  end
end
