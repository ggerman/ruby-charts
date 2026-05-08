# lib/ruby_charts/config.rb

module RubyCharts
  class Config
    # Default system fonts (adjust for your OS)
    DEFAULT_FONTS = {
      regular: '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf',
      bold: '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf'
    }.freeze
    
    # macOS alternatives
    MACOS_FONTS = {
      regular: '/Library/Fonts/Arial.ttf',
      bold: '/Library/Fonts/Arial Bold.ttf'
    }.freeze
    
    # Windows alternatives
    WINDOWS_FONTS = {
      regular: 'C:\\Windows\\Fonts\\arial.ttf',
      bold: 'C:\\Windows\\Fonts\\arialbd.ttf'
    }.freeze
    
    def self.font(style = :regular)
      case RUBY_PLATFORM
      when /darwin/
        MACOS_FONTS[style]
      when /mswin|mingw/
        WINDOWS_FONTS[style]
      else
        DEFAULT_FONTS[style]
      end
    end
    
    def self.font_exists?(path)
      File.exist?(path)
    end
  end
end
