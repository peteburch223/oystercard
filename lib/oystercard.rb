class Oystercard
  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_LIMIT = 1


  def initialize
    @balance = DEFAULT_BALANCE
    @in_use = false
  end

  def top_up(amount)
    raise "Exceeded £#{MAX_LIMIT} limit" if max_reached?(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @in_use
  end

  def touch_in
    raise "You must have over £#{Oystercard::MIN_LIMIT} on your card" if min_reached?
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def zero_balance?
    start_balance
  end

  private

  def start_balance
    @balance == DEFAULT_BALANCE
  end

  def max_reached?(amount)
    @balance + amount > MAX_LIMIT
  end

  def min_reached?
    @balance < MIN_LIMIT
  end

end
