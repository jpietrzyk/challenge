require 'csv'

class WeatherReader
  
  attr_accessor :weather_data, :days

  def initialize(weather_data)
    @days = []
    @weather_data = weather_data
    read_data
  end

  def smallest_spread
    
  end

  private

  def read_data
    File.readlines(weather_data)[2..-1].each do |line|
      day = line.split(' ')
      days << [day(day), min_temperature(day), max_temperature(day), spread(day)]
    end
  end


  def spread(day)
    max_temperature(day) - min_temperature(day)
  end

  def day(day)
    day[0]
  end

  def min_temperature(day)
    day[1].to_f
  end

  def max_temperature(day)
    day[2].to_f
  end

end