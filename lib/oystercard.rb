class Oystercard
  attr_reader :balance

  DEFAULT_BALANCE = 0
  TOP_UP_LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    limit?(amount)
    @balance += amount
  end

  private 

  def limit?(amount)
    message = "The top up limit is #{TOP_UP_LIMIT}"
    raise message if @balance + amount > TOP_UP_LIMIT
  end
end
