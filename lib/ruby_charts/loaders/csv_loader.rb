# lib/ruby_charts/loaders/csv_loader.rb

module RubyCharts
  module Loaders
    class CSVLoader
      def self.load(filepath, options = {})
        raise "File not found: #{filepath}" unless File.exist?(filepath)
        
        rows = CSV.read(filepath)
        headers = rows[0]
        data_rows = rows[1..-1]
        
        labels = data_rows.map { |row| row[0] }
        values = data_rows.map { |row| row[1].to_f }
        
        {
          labels: labels,
          values: values,
          type: options[:type] || :bar
        }
      end
    end
  end
end
