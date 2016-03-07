require 'oystercard'

describe Oystercard do
  subject(:oystercard){ described_class.new }
  let(:Oystercard){described_class}

  MONEY_AMOUNT = 10

  context 'initial tests' do
    it {is_expected.to respond_to(:balance)}
    it {is_expected.to respond_to(:top_up).with(1).argument}
    it {is_expected.to respond_to(:in_journey?)}
    it {is_expected.to respond_to(:touch_in)}
    it {is_expected.to respond_to(:touch_out)}
    it 'has an initial balance of zero' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#top_up' do

    it 'balance increases when money is added' do
      expect {oystercard.top_up(MONEY_AMOUNT)}.to change{oystercard.balance}.by(MONEY_AMOUNT)
    end

    it 'raises error if balance is greater than defined amount' do
      oystercard.top_up(Oystercard::MAX_BALANCE)
      expect {oystercard.top_up(1)}.to raise_error("Maximum balance of #{Oystercard::MAX_BALANCE} would be exceeded")
    end

  end

  describe '#deduct' do

    it 'balance decreases when money is deducted' do
      oystercard.top_up(Oystercard::MAX_BALANCE)
      expect {oystercard.deduct(MONEY_AMOUNT)}.to change{oystercard.balance}.by(-MONEY_AMOUNT)
    end

  end

  describe 'journey status' do
    it{is_expected.to_not be_in_journey}
  end

  describe '#touch_in' do
    it 'sets in_journey to be true' do
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'sets in_journey to be false' do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).to_not be_in_journey
    end
  end


end
