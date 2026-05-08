# lib/ruby_charts/loaders/yaml_loader.rb

module RubyCharts
  module Loaders
    class YAMLLoader
      def self.load(filepath, options = {})
        raise "File not found: #{filepath}" unless File.exist?(filepath)
        
        data = YAML.safe_load_file(filepath)
        
        if data.is_a?(Hash) && data['data']
          data = data['data']
        end
        
        labels = []
        values = []
        
        if data.is_a?(Array)
          data.each do |item|
            if item.is_a?(Hash)
              labels << item['name'] || item['label']
              values << (item['value'] || item['amount']).to_f
            end
          end
        elsif data.is_a?(Hash)
          data.each do |key, value|
            labels << key
            values << value.to_f
          end
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
