require 'journeylog'

describe JourneyLog do
  let(:station){ double :station }
  let(:journey){double :journey, complete?: true}
  let(:journey_class){double :journey_class, new: journey}
  subject {described_class.new(journey_class: journey_class)}

  describe "#start" do
    it "starts a journey" do
      expect(journey_class).to receive(:new).with(entry_station: station)
      subject.start(station)
    end
  end
end
