version = File.read("VERSION").strip

Gem::Specification.new do |s|
  s.name	= 'dnsrr'
  s.version	= version
  s.platform    = Gem::Platform::RUBY
  s.summary	= "rewrite dns requests"
  s.description	= "Rewrite DNS requests based on regular expressions and fall through if unknown"
  s.author	= "Chris Mague"
  s.email	= "github@mague.com"
  s.files	=  Dir['README.md', 'VERSION', 'Gemfile', 'Rakefile', '{bin,lib,config}/**/*']
  s.executables = ['dnsrr_control.rb']
  s.require_path = 'lib'
  s.add_dependency('rubydns')
end
