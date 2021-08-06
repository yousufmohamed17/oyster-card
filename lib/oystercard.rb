class Oystercard
  attr_reader :balance, :entry_station, :exit_station

  DEFAULT_BALANCE = 0
  TOP_UP_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
  end

  def top_up(amount)
    limit?(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    check_balance
    @entry_station = station
    @exit_station = nil
  end

  def touch_out(station)
    @entry_station = nil
    @exit_station = station
  end

  private 

  def limit?(amount)
    message = "The top up limit is #{TOP_UP_LIMIT}"
    raise message if @balance + amount > TOP_UP_LIMIT
  end

  def check_balance
    raise "You must top up" unless @balance >= MINIMUM_BALANCE
  end
end
