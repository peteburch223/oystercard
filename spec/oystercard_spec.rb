require 'oystercard'

describe Oystercard do
  subject(:oystercard){ described_class.new }

  TOP_UP_AMOUNT = 10

  context 'initial tests' do
    it {is_expected.to respond_to(:balance)}
    it {is_expected.to respond_to(:top_up).with(1).argument}
    it 'has an initial balance of zero' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'balance increases when money is added' do
      expect {oystercard.top_up(TOP_UP_AMOUNT)}.to change{oystercard.balance}.by(TOP_UP_AMOUNT)
    end
  end
end
