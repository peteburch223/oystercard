require 'oystercard'

describe Oystercard do
  subject(:Oystercard) {described_class}

  let(:station){double :station}
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:trip){{entry_station: entry_station, exit_station: exit_station}}

  let(:journey_class) { double :journey_class, new: journey_instance }
  let(:journey_instance) { double :journey_instance, add_station: nil, fare: Oystercard::MIN_FARE }
  subject(:oystercard) {described_class.new(journey_log_class: journey_class)}



  describe 'new card' do
    it 'with balance of £0' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'expect to add amount to card balance' do
      expect {oystercard.top_up(10)}.to change{oystercard.balance}.by 10
    end

    it "expects to raise error when max limit exceeded" do
      fare = Oystercard::MAX_LIMIT + 1
      expect{oystercard.top_up fare}.to raise_error Oystercard::MAX_ERROR
    end
  end

  describe '#in_journey' do
    before do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
    end

    it 'changes status of card to in use after touching in' do
      expect(oystercard).to be_in_journey
    end

    it 'deducts penalty fare when touch_in occurs in_journey' do
      allow(journey_instance).to receive(:fare).and_return(Oystercard::PENALTY_FARE)
      expect{oystercard.touch_in(entry_station)}.to change{oystercard.balance}.by -Oystercard::PENALTY_FARE
    end

    it 'stores partial journey when touch_in occurs in_journey' do
      oystercard.touch_in(entry_station)
      expect(oystercard.journeys).to include journey_instance
    end

    it 'returns status of card' do
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'raises error when minimum balance reached' do
      expect {oystercard.touch_in(entry_station)}.to raise_error Oystercard::MIN_ERROR
    end
  end

  describe '#touch_out' do
    before do
      oystercard.top_up(1)
    end
    it 'deducts fare from balance after touching out' do
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by -Oystercard::MIN_FARE
    end

    it 'deducts penalty fare when touch_out occurs not in_journey' do
      allow(journey_instance).to receive(:fare).and_return(Oystercard::PENALTY_FARE)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by -Oystercard::PENALTY_FARE
    end

    it 'stores journey upon touch out' do
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys).to include journey_instance
    end

    it 'only stores one journey if touch_in / touch_out sequence normal' do
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys.length).to eq 1
    end
  end

  describe '#journeys' do
    it 'starts with no journeys' do
      oystercard.top_up(1)
      expect(oystercard.journeys).to be_empty
    end
  end
end
