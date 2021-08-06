class Oystercard
  attr_reader :balance, :journey, :journey_log

  DEFAULT_BALANCE = 0
  TOP_UP_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey = nil
    @journey_log = []
  end

  def top_up(amount)
    limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    deduct(@journey.fare) if @journey != nil
    check_balance
    @journey = Journey.new(station)
  end

  def touch_out(station)
    @journey = Journey.new if @journey.nil?
    @journey_log << @journey.end_journey(station)
    deduct(@journey.fare)
    @journey = nil
  end

  private

  def limit?(amount)
    message = "The top up limit is #{TOP_UP_LIMIT}"
    raise message if @balance + amount > TOP_UP_LIMIT
  end

  def check_balance
    raise "You must top up" unless @balance >= MINIMUM_BALANCE
  end

  def deduct(fare)
    @balance -= fare
  end
end
