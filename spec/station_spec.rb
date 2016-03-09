require 'station'

describe Station do
  let(:name){"aldgate"}
  let(:zone){1}
  subject(:station){described_class.new(name,zone)}

  it{expect(station.name).to eq name}
  it{expect(station.zone).to eq zone}
end
