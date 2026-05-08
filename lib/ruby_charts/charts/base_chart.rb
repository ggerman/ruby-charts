# lib/ruby_charts/charts/base_chart.rb

require_relative '../config'

module RubyCharts
  module Charts
    class BaseChart
      COLORS = [
        [255, 107, 107],    # Red
        [78, 205, 196],     # Teal
        [69, 183, 209],     # Blue
        [255, 160, 122],    # Orange
        [154, 216, 200],    # Mint
        [247, 220, 111],    # Yellow
        [187, 143, 206],    # Purple
        [133, 193, 226],    # Light Blue
        [248, 184, 139],    # Peach
        [170, 190, 198]     # Gray
      ].freeze
      
      attr_accessor :data, :options
      
      def initialize(data)
        @data = data
        @options = {
          width: 1200,
          height: 700,
          title: 'Chart',
          subtitle: nil,
          colors: COLORS,
          padding: 80,
          font: Config.font(:regular),
          font_bold: Config.font(:bold)
        }
      end
      
      def title(text)
        @options[:title] = text
        self
      end
      
      def subtitle(text)
        @options[:subtitle] = text
        self
      end
      
      def colors(*color_array)
        @options[:colors] = color_array.flatten
        self
      end
      
      def font(path)
        @options[:font] = path
        self
      end
      
      def legend(position: :right)
        @options[:legend] = position
        self
      end
      
      def render
        @img = GD::Image.new(@options[:width], @options[:height])
        @img.fill([255, 255, 255])
        
        draw_background
        draw_title
        draw_chart_content
        
        @img
      end
      
      def save(filename)
        render.save(filename)
        puts "✓ Chart saved: #{filename}"
        filename
      end
      
      protected
      
      def draw_background
        @img.filled_rectangle(
          0, 0,
          @options[:width] - 1,
          @options[:height] - 1,
          [255, 255, 255]
        )
        
        @img.rectangle(
          0, 0,
          @options[:width] - 1,
          @options[:height] - 1,
          [200, 200, 200]
        )
      end
      
      def draw_title
        # Title background
        @img.filled_rectangle(
          0, 0,
          @options[:width] - 1,
          70,
          [250, 250, 250]
        )
        
        # Title border
        @img.line(0, 70, @options[:width] - 1, 70, [200, 200, 200])
        
        # Title text
        if File.exist?(@options[:font_bold])
          @img.text_ft(
            @options[:title],
            x: @options[:padding],
            y: 50,
            font: @options[:font_bold],
            size: 28,
            color: [30, 30, 30]
          )
        end
        
        # Subtitle text
        if @options[:subtitle] && File.exist?(@options[:font])
          @img.text_ft(
            @options[:subtitle],
            x: @options[:padding],
            y: 65,
            font: @options[:font],
            size: 12,
            color: [100, 100, 100]
          )
        end
      end
      
      def draw_chart_content
        raise NotImplementedError, 'Subclasses must implement draw_chart_content'
      end
      
      def get_color(index)
        @options[:colors][index % @options[:colors].length]
      end
      
      def draw_text(text, x, y, size, color)
        if File.exist?(@options[:font])
          @img.text_ft(
            text,
            x: x,
            y: y,
            font: @options[:font],
            size: size,
            color: color
          )
        end
      end
      
      def measure_text(text, size)
        if File.exist?(@options[:font])
          @img.text_bbox(
            text,
            font: @options[:font],
            size: size
          )
        else
          [text.length * size / 2, size]
        end
      end
    end
  end
end
