class Oystercard
  attr_reader :balance

  DEFAULT_BALANCE = 0

  def initialize
    @balance = DEFAULT_BALANCE
  end

  def top_up(amount)
    @balance += amount
  end

  def zero_balance?
    start_balance
  end

  private

  def start_balance
    @balance == DEFAULT_BALANCE
  end

end
