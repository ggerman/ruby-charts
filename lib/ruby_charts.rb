# lib/ruby_charts.rb

require 'gd'
require 'csv'
require 'yaml'
require 'roo'

require_relative 'ruby_charts/version'
require_relative 'ruby_charts/loaders/csv_loader'
require_relative 'ruby_charts/loaders/xlsx_loader'
require_relative 'ruby_charts/loaders/yaml_loader'
require_relative 'ruby_charts/charts/base_chart'
require_relative 'ruby_charts/charts/pie_chart'
require_relative 'ruby_charts/charts/bar_chart'
require_relative 'ruby_charts/charts/line_chart'
require_relative 'ruby_charts/builder'

module RubyCharts
  class Error < StandardError; end
  
  def self.from_csv(filepath, options = {})
    data = Loaders::CSVLoader.load(filepath, options)
    Builder.new(data)
  end
  
  def self.from_xlsx(filepath, options = {})
    data = Loaders::XLSXLoader.load(filepath, options)
    Builder.new(data)
  end
  
  def self.from_yaml(filepath, options = {})
    data = Loaders::YAMLLoader.load(filepath, options)
    Builder.new(data)
  end
  
  def self.from_hash(data_hash)
    Builder.new(data_hash)
  end
end
