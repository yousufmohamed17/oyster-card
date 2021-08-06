class JourneyLog
  attr_reader :journey, :journeys

  def initialize(journey)
    @journey = journey
    @journeys = []
  end
end
