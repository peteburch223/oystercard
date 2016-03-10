require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new(journey_class) }

  let(:entry_station) { double :station}
  let(:exit_station) { double :station}
  let(:journey_class) { double :journey_class, new:journey_instance }
  let(:journey_instance) { double :journey_instance, entry_st: nil, exit_st: nil, fare: Oystercard::MIN_VALUE }
  max_value = Oystercard::MAX_VALUE

  describe '#initialize' do
    it { expect(card.balance).to be_zero }
    it { expect(card.journey_history).to be_empty }
  end

  describe '#top_up' do
    it { expect{ card.top_up 1 }.to change{ card.balance }.by 1 }
    it { expect{ card.top_up (max_value + 1) }.to raise_error Oystercard::MAX_ERROR }
  end


  describe '#touch_in' do

    it { expect{card.touch_in(entry_station)}.to raise_error Oystercard::MIN_ERROR }


      it 'deducts PENALTY_FARE if not touched out' do
        card.top_up(5)
        card.touch_in(entry_station)
        allow(journey_instance).to receive(:fare) { Oystercard::PENALTY_FARE }
        expect{ card.touch_in(entry_station) }.to change{ card.balance }.by(-Oystercard::PENALTY_FARE)
      end
    end

  describe '#touch_out' do

    it 'should reduce the balance by minimum fare' do
      card.top_up(5)
      card.touch_in(entry_station)
      expect{ card.touch_out(exit_station) }.to change{ card.balance }.by(-Oystercard::MIN_FARE)
    end
    it 'deducts PENALTY_FARE if not touched in' do
      allow(journey_instance).to receive(:fare) { Oystercard::PENALTY_FARE }
      expect{ card.touch_out(entry_station) }.to change{ card.balance }.by(-Oystercard::PENALTY_FARE)
    end
    it 'save journey after touch_out' do
      card.top_up(5)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journey_history).to eq [journey_instance]
    end

  end
end
