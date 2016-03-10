require 'journey_log'

describe JourneyLog do

  subject(:journey_log) { described_class.new(journey_class) }
  let(:journey_class) { double :journey_class, new:journey_instance }
  let(:journey_instance) { double :journey_instance, entry_st: nil, exit_st: nil, fare: nil }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it {is_expected.to respond_to(:start)}
  it {is_expected.to respond_to(:finish)}
  it {is_expected.to respond_to(:journeys)}
  it {is_expected.to respond_to(:current_journey)}

  # describe '#initialize' do
  #   it { expect(journey_log.journey_history).to be_empty }
  # end

  describe '#current_journey' do
    it {expect(journey_log.current_journey).to eq journey_instance}
  end

  context 'normal journey' do
    it 'checks journeys are pushed into journey_history' do
    journey = journey_log.current_journey
    journey_log.start(entry_station)
    journey_log.finish(exit_station)
    expect(journey_log.journeys).to include(journey)
  end
  end

  describe 'start' do


    it 'create a new journey with entry station' do

    end

    it 'records a partial journey if journey in progress' do

    end

    it 'returns a fare if journey in progress' do

    end
  end
end
