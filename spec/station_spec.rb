require 'station'

describe Station do
  let(:station) { Station.new("Bank", 1) }
  it 'has a zone' do
    expect(station).to respond_to(:zone)
  end

  it 'has a name' do
    expect(station).to respond_to(:name)
  end

  it 'sets the name when you create it' do
    expect(station.name).to eq("Bank")
  end

  it 'sets the zone when you create it' do
    expect(station.zone).to eq(1)
  end
end