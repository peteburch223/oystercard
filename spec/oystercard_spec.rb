require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  describe 'new card' do
    it 'with balance of £0' do
      expect(oystercard).to be_zero_balance
    end
  end

  describe '#top_up' do
    it 'expect to add to balance' do
      expect {oystercard.top_up(10)}.to change{oystercard.balance}.by 10
    end

    it "expects to raise error when max limit exceeded" do
      fare = Oystercard::MAX_LIMIT + 1
      message = "Exceeded £#{Oystercard::MAX_LIMIT} limit"
      expect{oystercard.top_up fare}.to raise_error message
    end
  end

end
