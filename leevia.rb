#!/usr/bin/ruby
# frozen_string_literal: true

require 'csv'

# CSV extract cities with highest altitude
class WorldCityLocation
  attr_accessor :csv_data, :cities

  def initialize(path = 'World_Cities_Location_table.csv')
    file = File.read(path)
    @csv_data = CSV.parse(file, headers: false, liberal_parsing: true, col_sep: ';')
    @cities = {}
  end

  def filter_cities
    @csv_data.sort_by { |c| c[-1].to_f }            # c[-1] == altitude
             .map { |d| @cities[d[1].to_sym] = d }  # d[1] == country
    @cities.sort_by { |_k, v| v[-1].to_f }.reverse  # v[-1] == altitude
  end

  def write_txt(name = 'output.txt')
    f = File.open(name, 'w')
    ios = IO.new $stdout.fileno
    filter_cities.each do |k, v| # k == name country, v == data
      text = "#{v[-1]}m - #{v[2]}, #{k}\n"
      f.puts text
      ios.puts text
    end
    f.close
    ios.close
  end


end

world_city = WorldCityLocation.new

world_city.write_txt



