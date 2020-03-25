require 'journey'

describe Journey do
  it "can be started" do
    expect(subject).to respond_to(:start).with(1).argument
  end

  it "can finish" do
    expect(subject).to respond_to(:finish).with(1).argument
  end

  it "can calulate the fare" do
    expect(subject).to respond_to(:calculate_fare)
  end

  it "can say if the journey was completed" do
    expect(subject).to respond_to(:complete?)
  end

  it "gives false if journey has been started" do
    journey = Journey.new
    journey.start("Bank")
    expect(journey.complete?).to eq false
  end

  it "gives true of journey has finished" do
    journey = Journey.new
    journey.start("Bank")
    journey.finish("Euston")
    expect(journey.complete?).to eq true
  end
end
