require 'oystercard'

describe Oystercard do
  let(:station){double :station}
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { double :journey }

  let(:trip){{entry_station: entry_station, exit_station: exit_station}}

  subject(:oystercard) {described_class.new(journey_class: journey)}
  subject(:Oystercard) {described_class}

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
      oystercard.top_up(1)
      oystercard.touch_in(entry_station)
    end

    it 'returns status of card' do
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end

    it 'changes status of card to in use after touching in' do
      expect(oystercard).to be_in_journey
    end

    it 'changes status of card to not in use after touching out' do
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



    it 'deducts fare from balance after touching out' do
      oystercard.top_up(1)
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by -Oystercard::MIN_FARE
    end

    it 'stores journey upon touch out' do
      oystercard.top_up(1)
      allow(journey).to receive(:add_station).with(entry_station)
      allow(journey).to receive(:add_station).with(exit_station)
      allow(subject).to receive(:new_journey).and_return(journey)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys).to include trip
    end

  end

  describe '#journeys' do

    it 'starts with no journeys' do
      oystercard.top_up(1)
      expect(oystercard.journeys).to be_empty
    end

  end
end
