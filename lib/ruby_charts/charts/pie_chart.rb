# lib/ruby_charts/charts/pie_chart.rb

module RubyCharts
  module Charts
    class PieChart < BaseChart
      protected
      
      def draw_chart_content
        chart_area_width = @options[:width] - (2 * @options[:padding])
        chart_area_height = @options[:height] - (2 * @options[:padding]) - 120
        
        center_x = @options[:padding] + (chart_area_width / 2)
        center_y = @options[:padding] + 70 + (chart_area_height / 2)
        radius = [chart_area_width, chart_area_height].min / 3
        
        total = @data[:values].sum.to_f
        current_angle = -90  # Start from top
        
        @data[:labels].each_with_index do |label, index|
          value = @data[:values][index]
          percentage = (value / total) * 100
          angle = (percentage / 100.0) * 360
          
          color = get_color(index)
          
          # Draw pie slice using polygon
          draw_pie_slice(center_x, center_y, radius, current_angle, angle, color)
          
          # Draw percentage label
          draw_slice_label(center_x, center_y, radius, current_angle, angle, percentage)
          
          # Draw legend
          draw_legend_item(index, label, percentage, color)
          
          current_angle += angle
        end
      end
      
      private
      
      def draw_pie_slice(cx, cy, radius, start_angle, angle, color)
        # Build polygon points for pie slice
        points = [[cx, cy]]
        
        steps = (angle / 5).ceil
        (0..steps).each do |i|
          current_angle = start_angle + (angle * i / steps)
          rad = (current_angle * Math::PI / 180)
          
          x = (cx + radius * Math.cos(rad)).to_i
          y = (cy + radius * Math.sin(rad)).to_i
          points << [x, y]
        end
        
        # Draw filled polygon (pie slice)
        @img.filled_polygon(points, color)
        
        # Draw border
        @img.polygon(points, [100, 100, 100])
      end
      
      def draw_slice_label(cx, cy, radius, start_angle, angle, percentage)
        label_angle = start_angle + (angle / 2)
        label_radius = radius * 0.65
        
        rad = (label_angle * Math::PI / 180)
        label_x = (cx + label_radius * Math.cos(rad)).to_i
        label_y = (cy + label_radius * Math.sin(rad)).to_i
        
        text = "#{percentage.round(1)}%"
        
        draw_text(text, label_x - 25, label_y, 11, [255, 255, 255])
      end
      
      def draw_legend_item(index, label, percentage, color)
        # Legend at bottom
        items_per_row = 3
        row = index / items_per_row
        col = index % items_per_row
        
        legend_x = @options[:padding] + (col * (@options[:width] - 2 * @options[:padding]) / 3)
        legend_y = @options[:height] - 50 + (row * 25)
        
        # Legend color box
        @img.filled_rectangle(legend_x, legend_y, legend_x + 15, legend_y + 15, color)
        @img.rectangle(legend_x, legend_y, legend_x + 15, legend_y + 15, [100, 100, 100])
        
        # Legend text
        text = "#{label}: #{percentage.round(1)}%"
        draw_text(text, legend_x + 25, legend_y + 13, 10, [50, 50, 50])
      end
    end
  end
end
