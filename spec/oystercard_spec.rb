require 'oystercard'

describe Oystercard do
  subject(:oystercard){ described_class.new }

  TOP_AMOUNT = 10

  it {is_expected.to respond_to(:balance)}

  it 'has an initial balance of zero' do
    expect(oystercard.balance).to eq(0)
  end

  it {is_expected.to respond_to(:top_up).with(1).argument}

  it 'balance increases when money is added' do
    oystercard.top_up(TOP_AMOUNT)
    expect(oystercard.balance).to eq TOP_AMOUNT
  end


end
