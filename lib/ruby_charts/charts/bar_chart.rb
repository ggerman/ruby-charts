# lib/ruby_charts/charts/bar_chart.rb

module RubyCharts
  module Charts
    class BarChart < BaseChart
      def initialize(data, orientation = :vertical)
        super(data)
        @orientation = orientation
      end
      
      def horizontal!
        @orientation = :horizontal
        self
      end
      
      def vertical!
        @orientation = :vertical
        self
      end
      
      protected
      
      def draw_chart_content
        if @orientation == :horizontal
          draw_horizontal_bars
        else
          draw_vertical_bars
        end
      end
      
      private
      
      def draw_vertical_bars
        chart_width = @options[:width] - (2 * @options[:padding])
        chart_height = @options[:height] - (2 * @options[:padding]) - 100
        
        max_value = @data[:values].max.to_f
        bar_width = (chart_width / @data[:labels].length) * 0.6
        spacing = chart_width / @data[:labels].length
        
        @data[:labels].each_with_index do |label, index|
          value = @data[:values][index]
          bar_height = (value / max_value) * chart_height
          
          x1 = @options[:padding] + (index * spacing) + ((spacing - bar_width) / 2)
          y1 = @options[:height] - @options[:padding] - bar_height.to_i
          x2 = x1 + bar_width.to_i
          y2 = @options[:height] - @options[:padding]
          
          color = get_color(index)
          
          # Draw bar
          @img.filled_rectangle(x1.to_i, y1.to_i, x2.to_i, y2.to_i, color)
          @img.rectangle(x1.to_i, y1.to_i, x2.to_i, y2.to_i, [100, 100, 100])
          
          # Draw value label on top of bar
          draw_text(value.to_i.to_s, x1.to_i + 5, y1 - 10, 10, [50, 50, 50])
          
          # Draw label below bar
          draw_text(label, x1.to_i, y2 + 20, 10, [50, 50, 50])
        end
        
        # Draw axes
        draw_axes(max_value)
      end
      
      def draw_horizontal_bars
        chart_width = @options[:width] - (2 * @options[:padding]) - 150
        chart_height = @options[:height] - (2 * @options[:padding]) - 100
        
        max_value = @data[:values].max.to_f
        bar_height = (chart_height / @data[:labels].length) * 0.6
        spacing = chart_height / @data[:labels].length
        
        @data[:labels].each_with_index do |label, index|
          value = @data[:values][index]
          bar_width = (value / max_value) * chart_width
          
          y1 = @options[:padding] + 50 + (index * spacing) + ((spacing - bar_height) / 2)
          x1 = @options[:padding] + 150
          y2 = y1 + bar_height.to_i
          x2 = x1 + bar_width.to_i
          
          color = get_color(index)
          
          # Draw bar
          @img.filled_rectangle(x1.to_i, y1.to_i, x2.to_i, y2.to_i, color)
          @img.rectangle(x1.to_i, y1.to_i, x2.to_i, y2.to_i, [100, 100, 100])
          
          # Draw label on left
          draw_text(label, 20, y1.to_i + 15, 10, [50, 50, 50])
          
          # Draw value on right
          draw_text(value.to_i.to_s, x2 + 10, y1.to_i + 15, 10, [50, 50, 50])
        end
      end
      
      def draw_axes(max_val)
        # X axis
        @img.line(
          @options[:padding],
          @options[:height] - @options[:padding],
          @options[:width] - @options[:padding],
          @options[:height] - @options[:padding],
          [0, 0, 0]
        )
        
        # Y axis
        @img.line(
          @options[:padding],
          @options[:padding] + 70,
          @options[:padding],
          @options[:height] - @options[:padding],
          [0, 0, 0]
        )
        
        # Grid lines and Y labels
        5.times do |i|
          value = (max_val * i / 4).to_i
          y = @options[:height] - @options[:padding] - (i * (@options[:height] - 2 * @options[:padding] - 100) / 4)
          
          # Grid line
          @img.line(
            @options[:padding],
            y.to_i,
            @options[:width] - @options[:padding],
            y.to_i,
            [230, 230, 230]
          )
          
          # Y label
          draw_text(value.to_s, 20, y.to_i + 5, 9, [100, 100, 100])
        end
      end
    end
  end
end
