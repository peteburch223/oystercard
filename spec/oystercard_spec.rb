require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  describe '#balance' do
    it 'checks that it has a balance' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'increases balance by given amount' do
      expect { oystercard.top_up(8) }.to change{ oystercard.balance }.by(8)
    end
  end
end
