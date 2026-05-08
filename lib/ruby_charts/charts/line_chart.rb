# lib/ruby_charts/charts/line_chart.rb

module RubyCharts
  module Charts
    class LineChart < BaseChart
      protected
      
      def draw_chart_content
        chart_width = @options[:width] - (2 * @options[:padding])
        chart_height = @options[:height] - (2 * @options[:padding]) - 100
        
        max_value = @data[:values].max.to_f
        min_value = @data[:values].min.to_f
        range = max_value - min_value
        range = 1 if range == 0
        
        # Draw grid
        draw_grid(chart_width, chart_height)
        
        # Calculate points
        points = @data[:values].each_with_index.map do |value, index|
          x = @options[:padding] + (index * chart_width / ([@data[:values].length - 1, 1].max))
          y = @options[:height] - @options[:padding] - ((value - min_value) / range * chart_height)
          [x.to_i, y.to_i]
        end
        
        color = get_color(0)
        
        # Draw line segments
        points.each_cons(2) do |p1, p2|
          @img.line(p1[0], p1[1], p2[0], p2[1], color)
        end
        
        # Draw points as circles
        points.each_with_index do |point, index|
          @img.filled_circle(point[0], point[1], 5, color)
          @img.circle(point[0], point[1], 5, [100, 100, 100])
          
          # Draw label
          draw_text(@data[:labels][index], point[0] - 20, point[1] - 20, 9, [50, 50, 50])
        end
        
        # Draw axes
        draw_axes(max_value, min_value)
      end
      
      private
      
      def draw_grid(width, height)
        # Horizontal grid lines
        5.times do |i|
          y = @options[:padding] + 70 + (i * height / 4)
          @img.line(
            @options[:padding],
            y,
            @options[:width] - @options[:padding],
            y,
            [230, 230, 230]
          )
        end
      end
      
      def draw_axes(max_val, min_val)
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
        
        # Y axis labels
        5.times do |i|
          value = (min_val + ((max_val - min_val) * i / 4)).to_i
          y = @options[:height] - @options[:padding] - (i * (@options[:height] - 2 * @options[:padding] - 100) / 4)
          
          draw_text(value.to_s, 20, y.to_i + 5, 9, [100, 100, 100])
        end
      end
    end
  end
end
