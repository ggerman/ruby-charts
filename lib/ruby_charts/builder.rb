# lib/ruby_charts/builder.rb

module RubyCharts
  class Builder
    def initialize(data)
      @data = data
      @chart_type = :bar
      @title = 'Chart'
      @subtitle = nil
      @colors = nil
      @legend = nil
    end
    
    def type(chart_type)
      @chart_type = chart_type
      self
    end
    
    def title(text)
      @title = text
      self
    end
    
    def subtitle(text)
      @subtitle = text
      self
    end
    
    def colors(*color_array)
      @colors = color_array.flatten
      self
    end
    
    def legend(position: :right)
      @legend = position
      self
    end
    
    def save(filename)
      chart = build_chart
      chart.title(@title)
      chart.subtitle(@subtitle)
      chart.colors(*@colors) if @colors
      chart.legend(position: @legend) if @legend
      
      chart.save(filename)
    end
    
    private
    
    def build_chart
      case @chart_type
      when :pie
        Charts::PieChart.new(@data)
      when :bar, :vertical_bar
        Charts::BarChart.new(@data, :vertical)
      when :horizontal_bar
        Charts::BarChart.new(@data, :horizontal)
      when :line
        Charts::LineChart.new(@data)
      else
        raise "Unknown chart type: #{@chart_type}"
      end
    end
  end
end
