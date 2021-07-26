require "station"

class OysterCard

  LIMIT = 90
  MINIMUM = 1

  attr_reader :journeys

  def initialize(balance: 0, station: Station.new, in_journey: nil, journeys: Array.new)
    @balance = balance
    @in_journey = in_journey
    @station = station
    @journeys = journeys
  end

  def balance
    return @balance
  end

  def top_up(amount)
    fail "Balance cannot exceed #{LIMIT}!" if limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Balance below #{MINIMUM}!" if minimumBalance?
    @station.in(station)
    @in_journey = true
  end

  def touch_out(exit)
    deduct(MINIMUM)
    @journeys.append({entry: @station.station, exit: exit})
    @in_journey = false
  end

  def in_journey?
    return @in_journey
  end

  private
  def minimumBalance?
    @balance < MINIMUM
  end

  def limit?(amount)
    @balance + amount > LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end

end
