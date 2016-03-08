require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  describe 'new card' do
    it 'with balance of £0' do
      expect(oystercard).to be_zero_balance
    end
  end

  describe '#top_up' do
    it 'expect to add amount to card balance' do
      expect {oystercard.top_up(10)}.to change{oystercard.balance}.by 10
    end

    it "expects to raise error when max limit exceeded" do
      fare = Oystercard::MAX_LIMIT + 1
      message = "Exceeded £#{Oystercard::MAX_LIMIT} limit"
      expect{oystercard.top_up fare}.to raise_error message
    end
  end

  describe '#deduct' do
    it 'deducts amount from card balance' do
      oystercard.top_up(12)
      expect {oystercard.deduct(5)}.to change{oystercard.balance}.by -5
    end
  end

end
