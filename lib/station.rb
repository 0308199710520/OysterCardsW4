class Station

  def initialize
    @station = nil
  end

  def in(station)
    @station = station
  end

  def out
    @station = nil
  end

  def station
    return @station
  end
end