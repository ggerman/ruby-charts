# lib/ruby_charts/loaders/xlsx_loader.rb

module RubyCharts
  module Loaders
    class XLSXLoader
      def self.load(filepath, options = {})
        raise "File not found: #{filepath}" unless File.exist?(filepath)
        
        workbook = Roo::Excelx.new(filepath)
        sheet = options[:sheet] || workbook.default_sheet
        workbook.sheet(sheet)
        
        labels = []
        values = []
        
        (2..workbook.last_row).each do |row|
          label = workbook.cell(row, 1)
          value = workbook.cell(row, 2)
          
          next if label.nil? || value.nil?
          
          labels << label.to_s
          values << value.to_f
        end
        
        {
          labels: labels,
          values: values,
          type: options[:type] || :bar
        }
      end
    end
  end
end
