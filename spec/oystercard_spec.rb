require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  describe 'new card' do
    it 'with balance of £0' do
      expect(oystercard).to be_zero_balance
    end
  end
end
