require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe '#initialize' do

    it { expect(journey.entry_station).to eq nil }

    it { expect(journey.exit_station).to eq nil }
  end

  describe '#entry_station' do
    it { expect(journey.entry_st(entry_station)).to eq entry_station }
  end

  describe '#exit_station' do
    it { expect(journey.exit_st(exit_station)).to eq exit_station }
  end

  describe '#fare' do
    it 'returns MIN_VALUE if entry_station and exit_station are set' do
      journey.entry_st(entry_station)
      journey.exit_st(exit_station)
      expect(journey.fare).to eq Journey::MIN_FARE
    end
    it 'returns PENALTY_FARE if entry_station is set and exit_station is nil' do
      journey.entry_st(entry_station)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
    it 'returns PENALTY_FARE if entry_station is nil and exit_station is set' do
      journey.exit_st(exit_station)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
    it 'return 0 if entry_station and exit_station are not set' do
      expect(journey.fare).to eq 0
    end
  end




end
