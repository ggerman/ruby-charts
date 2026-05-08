# ruby-charts.gemspec

Gem::Specification.new do |s|
  s.name        = 'ruby-charts'
  s.version     = '0.1.2a'
  s.authors     = ['Germán Silva']
  s.email       = ['ggerman@gmail.com']
  s.summary     = 'Professional charts from data files using ruby-libgd'
  s.description = 'Generate pie, bar, and line charts from CSV/XLSX/YAML'
  s.homepage    = 'https://github.com/ggerman/ruby-charts'
  s.license     = 'MIT'
  
  s.files       = Dir['lib/**/*'] + ['README.md', 'LICENSE']
  s.test_files  = Dir['spec/**/*']
  
  s.require_paths = ['lib']
  
  s.add_dependency 'ruby-libgd', '>= 0.3.0'
  s.add_dependency 'csv'
  s.add_dependency 'roo', '>= 2.10.0'
  s.add_dependency 'yaml'
  
  s.required_ruby_version = '>= 2.7.0'
end
