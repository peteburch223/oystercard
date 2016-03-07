require 'oystercard'

describe Oystercard do
  subject(:oystercard){ described_class.new }
  let(:Oystercard){described_class}

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

    it 'raises error if balance is greater than defined amount' do
      oystercard.top_up(Oystercard::MAX_BALANCE)
      expect {oystercard.top_up(1)}.to raise_error("Maximum balance of #{Oystercard::MAX_BALANCE} would be exceeded")
    end
  end
end
