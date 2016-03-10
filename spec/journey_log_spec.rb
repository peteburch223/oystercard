require 'journey_log'

describe JourneyLog do

  subject(:journey_log) { described_class.new(journey_class) }
  let(:journey_class) { double :journey_class, new:journey_instance }
  let(:journey_instance) { double :journey_instance, entry_st: nil, exit_st: nil, fare: nil }


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

  describe 'start' do
    it 'create a new journey with entry station' do

    end

    it 'records a partial journey if journey in progress' do

    end

    it 'returns a fare if journey in progress' do

    end    
  end
end
