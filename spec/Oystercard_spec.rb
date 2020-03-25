require './lib/oystercard'

describe Oystercard do
  let(:card) { Oystercard.new }
  let(:topped_up_card) { Oystercard.new(50) }
  let(:maxed_out_card) { Oystercard.new(Oystercard::CARD_LIMIT) }
  let(:station) { double(:station) }
  let(:exit_station) { double(:station) }

  context 'balance' do
    it "should respond to balance" do
      expect(subject).to respond_to(:balance)
    end

    it "balance should respond to class with an integer" do
      expect(subject.balance).to eq 0
    end

    it "should respond to top_up" do
      expect(subject).to respond_to(:top_up)
    end

    it "balance should be increased by topping up" do
      top_up_amount = 10
      expect { topped_up_card.top_up(top_up_amount) }.to change { topped_up_card.balance }.by top_up_amount
    end

    it "doesn't top up past limit" do
      expect { subject.top_up(Oystercard::CARD_LIMIT + 1) }.to raise_error "you cannot top up #{(Oystercard::CARD_LIMIT) + 1} as it brings your card over the limit"
    end
  end

  context 'touching in/out' do
    it " should be able to touch into system" do
      expect(card).to respond_to(:touch_in)
    end
    it " should be able to touch out of system" do
      expect(card).to respond_to(:touch_out).with(1).argument
    end
    it "should be able to let you know if it's in a journey" do
      topped_up_card.touch_in(station)
      expect(topped_up_card.in_journey?).to eq(true).or eq(false)
    end
    it "should return true if you are in the system" do
      card.top_up(Oystercard::CARD_LIMIT)
      card.touch_in(station)
      expect(card.in_journey?).to eq(true)
    end
    it "should return false if you are out the system" do
      topped_up_card.touch_in(station)
      topped_up_card.touch_out(station)
      expect(topped_up_card.in_journey?).to eq(false)
    end
    it 'will not touch in if below balance is below minimum' do
      expect{ card.touch_in(station) }.to raise_error "Insufficient balance to touch in"
    end
    it "balance will be reduced by the minimum amount after touch out" do
      maxed_out_card.touch_in(station)
      maxed_out_card.touch_out(station)
      expect(maxed_out_card.balance).to eq(Oystercard::CARD_LIMIT - Oystercard::MINIMUM_BALANCE)
    end

    it 'remembers the station when you touch in' do
      topped_up_card.touch_in(station)
      expect(topped_up_card.entry_station).to eq(station)
    end
    it "it gives you access to previous journeys" do
      expect(subject).to respond_to(:previous_journeys)
    end
    
    xit "Has a list of previous journeys" do
      maxed_out_card.touch_in(station)
      maxed_out_card.touch_out(exit_station)
      expect(maxed_out_card.previous_journeys).to eq([{ entry_station: station, exit_station: exit_station}])
    end
  end
end



#my_num = 5
#return my_num.class?
