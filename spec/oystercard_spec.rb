require 'oystercard'

describe OysterCard do
  subject(:oystercard){ described_class.new }

  it {is_expected.to respond_to(:balance)}

  it 'has an initial balance of zero' do
    expect(subject.balance).to eq(0)
  end
end
