class Journey
  attr_reader :start_station, :finish_station

  def start(station)
    @start_station = station
    @complete = false
  end

  def finish(station)
    @finish_station = station
    @complete = true
  end

  def calculate_fare
  end

  def complete?
    if @complete == false
      false
    else
      true
    end
  end
end
