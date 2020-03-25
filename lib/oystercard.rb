class Oystercard

  attr_reader :balance, :min_balance, :entry_station

  STARTING_BALANCE = 0
  CARD_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize(balance = STARTING_BALANCE)
    @balance = balance
    @journeys_taken = []
    @current_journey = nil
  end

  def top_up(num)
    raise "you cannot top up #{num} as it brings your card over the limit" if @balance + num > CARD_LIMIT
    @balance += num
  end

  def touch_in(station)
    @current_journey = Journey.new
    @current_journey.start(station)
    @entry_station = station
    if @balance < MINIMUM_BALANCE
      raise "Insufficient balance to touch in"
    elsif @balance >= MINIMUM_BALANCE
      @in_system = true ##get rid of in_system?
    end
  end

  def touch_out(station)
    deduct
    @current_journey.finish(station)
    @journeys_taken << @current_journey
    @entry_station = nil
  end

  def in_journey?
    if @current_journey.complete?
      false
    else
      true
    end
  end

  def previous_journeys
    @journeys_taken
  end

  private

  def deduct
    @balance -= MINIMUM_BALANCE
  end
end
