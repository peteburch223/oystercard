require 'oystercard'

describe Oystercard do
  MIN_FARE = 1
  PENALTY_FARE = 6

  subject(:card) { described_class.new(journey_log_instance) }

  let(:entry_station) { double :station}
  let(:exit_station) { double :station}
  let(:journey_class) { double :journey_class, new:journey_instance }
  let(:journey_instance) { double :journey_instance, entry_st: nil, exit_st: nil, fare: Oystercard::MIN_VALUE, in_progress?: false }
  let(:journey_log_instance) { double :journey_log, start: nil, finish: nil, current_journey: journey_instance, store_journey: nil }


  describe '#initialize' do
    it { expect(card.balance).to be_zero }
  end

  describe '#top_up' do
    it { expect{ card.top_up 1 }.to change{ card.balance }.by 1 }
    it { expect{ card.top_up (Oystercard::MAX_VALUE + 1) }.to raise_error Oystercard::MAX_ERROR }
  end


  describe '#touch_in' do

    it { expect{card.touch_in(entry_station)}.to raise_error Oystercard::MIN_ERROR }


      it 'deducts PENALTY_FARE if not touched out' do
        card.top_up(10)
        card.touch_in(entry_station)
        allow(journey_instance).to receive(:fare) { PENALTY_FARE }
        allow(journey_instance).to receive(:in_progress?) { true }
        expect{ card.touch_in(entry_station) }.to change{ card.balance }.by(-PENALTY_FARE)
      end
    end

  describe '#touch_out' do

    it 'should reduce the balance by minimum fare' do
      card.top_up(5)
      card.touch_in(entry_station)
      expect{ card.touch_out(exit_station) }.to change{ card.balance }.by(-MIN_FARE)
    end
    it 'deducts PENALTY_FARE if not touched in' do
      allow(journey_instance).to receive(:fare) { PENALTY_FARE }
      expect{ card.touch_out(entry_station) }.to change{ card.balance }.by(-PENALTY_FARE)
    end

  end
end
