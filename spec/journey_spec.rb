require 'journey'

describe Journey do
  subject(:journey){described_class.new}
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:trip_start){{entry_station: entry_station}}
  let(:trip_end){{exit_station: exit_station}}



  it{expect(journey.trip).to eq ({})}

  it 'returns minimum fare when trip completed' do
    journey.add_station(trip_start)
    journey.add_station(trip_end)
    expect(journey.fare).to eq Journey::MIN_FARE
  end

  it 'returns penalty fare when trip not completed' do
    journey.add_station(trip_start)
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'returns penalty fare when trip not started' do
    journey.add_station(trip_end)
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

end
