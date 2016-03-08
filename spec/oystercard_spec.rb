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

  describe '#in_journey' do

    it 'returns status of card' do
      expect(oystercard.in_journey?).to be false
      expect(oystercard).not_to be_in_journey
    end

    it 'changes status of card to in use after touching in' do
      oystercard.top_up(1)
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it 'changes status of card to not in use after touching out' do
      oystercard.top_up(1)
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'raises error when minimum balance reached' do
      message = "You must have over £#{Oystercard::MIN_LIMIT} on your card"
      expect {oystercard.touch_in}.to raise_error message
    end
  end

end
