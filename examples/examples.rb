#!/usr/bin/env ruby

require_relative '../lib/ruby_charts'

# Create output directory
FileUtils.mkdir_p('output')

puts "Generating charts...\n\n"

# 1. CSV → Pie Chart
puts "1. Creating pie chart from CSV..."
RubyCharts.from_csv('csv/sales.csv')
  .type(:pie)
  .title('Product Sales Distribution')
  .subtitle('Q1 2024')
  .save('output/pie_chart.png')

# 2. CSV → Vertical Bar Chart
puts "2. Creating vertical bar chart from CSV..."
RubyCharts.from_csv('csv/sales.csv')
  .type(:bar)
  .title('Product Sales Comparison')
  .subtitle('Q1 2024')
  .save('output/bar_chart_vertical.png')

# 3. CSV → Horizontal Bar Chart
puts "3. Creating horizontal bar chart from CSV..."
RubyCharts.from_csv('csv/sales.csv')
  .type(:horizontal_bar)
  .title('Product Sales - Horizontal View')
  . save('output/bar_chart_horizontal.png')

# 4. YAML → Line Chart
puts "4. Creating line chart from YAML..."
RubyCharts.from_yaml('yml/data.yml')
  .type(:line)
  .title('Monthly Revenue Trend')
  .subtitle('2024')
  .save('output/line_chart.png')

# 5. Hash → Pie Chart (inline data)
puts "5. Creating pie chart from hash..."
data = {
  labels: ['Product A', 'Product B', 'Product C'],
  values: [300, 450, 250]
}

RubyCharts.from_hash(data)
  .type(:pie)
  .title('Market Share')
  .save('output/pie_inline.png')

puts "\n✓ All charts generated!"
puts "✓ Check output/ directory for results"
