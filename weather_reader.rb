require 'csv'

class WeatherReader
  
  attr_accessor :weather_data, :days

  def initialize(weather_data)
    @days = []
    @weather_data = weather_data
    read_data
    p output
  end

  def smallest_spread_day
    sort_by_spread.last[0].to_i
  end

  def bigest_spread_day
    sort_by_spread.first[0].to_i
  end

  def order_by(value)
    vql = get_id_by_name
    days.sort { |a,b| a[val] <=> b[val] }
  end

  def output
    "the day number with smallest spread is #{smallest_spread_day}"
  end

  private

  def read_data
    File.readlines(weather_data)[2..-1].each do |line|
      day = line.split(' ')
      days << [
        day(day), 
        min_temperature(day), 
        max_temperature(day), 
        spread(day)
      ]
    end
  end

  def sort_by_spread
    days.sort { |a,b| a[3] <=> b[3] }
  end

  def spread(day)
    max_temperature(day) - min_temperature(day)
  end

  def day(day)
    day[get_id_by_name('day')]
  end

  def min_temperature(day)
    day[get_id_by_name('MnT')].to_f
  end

  def max_temperature(day)
    day[get_id_by_name('MxT')].to_f
  end

  def get_id_by_name(name)
    id = case name
      when 'day' then 0
      when 'MxT' then 1
      when 'MnT' then 2
      when 'Avt' then 3
      when 'HDDay' then 4
      when 'AvDP' then 5
      when '1HrP' then 6
      when 'TPcpn' then 7
      when 'PDir' then 9
      when 'AvSp' then 10
      when 'Dir' then 11
      when 'MxS' then 12
      when 'SkyC' then 13
      when 'Mxr' then 14
      when 'MnR' then 15
      when 'AvSLP' then 16
      else 0
    end
  end

end
