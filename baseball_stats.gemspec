$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'baseball_stats/version'

Gem::Specification.new do |s|
  s.name = 'baseball_stats'
  s.version = BaseballStats::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['']
  s.email = ['']
  s.summary = 'Command line tool for getting baseball statistics'

  s.files = %w(
    bin/baseball_stats
    lib/baseball_stats.rb
    lib/baseball_stats/batting_stats.rb
    lib/baseball_stats/batting_stats/player_stats.rb
    lib/baseball_stats/player.rb
    lib/baseball_stats/version.rb
  )

  s.require_paths = ['lib']
  s.executables = ['baseball_stats']

  s.add_development_dependency('pry', '~> 0.9')
end
