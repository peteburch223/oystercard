require 'journey_log'
describe JourneyLog do

  let (:journey_class) {double :journey_class, new:journey_instance}
  let(:journey_instance) { double :journey_instance, add_station: nil}
  subject(:journeylog) {described_class.new(journey_class: journey_class)}

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:trip){{entry_station: entry_station, exit_station: exit_station}}


  it{is_expected.to respond_to(:start)}
  it{is_expected.to respond_to(:finish)}
  it{is_expected.to respond_to(:current_journey)}
  it{is_expected.to respond_to(:journeys)}

  describe '#current_journey' do
    it 'creates a new journey  object if no journey in progress' do
      expect(journeylog.current_journey).to eq journey_instance
    end

    it 'returns current journey if journey in progress' do
      journeylog.current_journey
      expect(journeylog.current_journey).to eq journey_instance
    end
  end

  it 'stores complete journey' do
    journeylog.current_journey
    journeylog.start(entry_station)
    journeylog.finish(exit_station)
    journeylog.commit
    expect(journeylog.journeys).to include journey_instance
  end

  # describe '#start' do
  #   let(:trip){{entry_station: entry_station}}
  #   it 'stores entry station in @journey' do
  #     journeylog.current_journey
  #     allow(journey_instance).to receive(:trip).and_return(trip)
  #     journeylog.start(entry_station)
  #     expect(journeylog.current_journey.trip).to include trip
  #   end
  # end
  #
  # describe '#finish' do
  #   it 'stores exit station in @journey' do
  #     journeylog.current_journey
  #     journeylog.finish(exit_station)
  #     allow(journey_instance).to receive(:trip).and_return(exit_station)
  #     expect(journeylog.current_journey.trip).to eq exit_station
  #   end
  # end

end
