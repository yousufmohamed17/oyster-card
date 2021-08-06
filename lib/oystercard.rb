class Oystercard
  attr_reader :balance

  DEFAULT_BALANCE = 0
  TOP_UP_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @current_journey = nil
  end

  def top_up(amount)
    limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    deduct if @current_journey != nil
    check_balance
    @current_journey = Journey.new
    @current_journey.start_journey(station)
  end

  def touch_out(station)
    if @current_journey = nil
      deduct
      @current_journey = Journey.new
    end
    deduct
    @current_journey.end_journey(station)
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
