#!/usr/bin/env ruby

require 'rubygems' if RUBY_VERSION < "1.9"
require "rubydns"
require "yaml"
require 'getoptlong'
require 'pathname'

args = {  :pidfile => "/tmp/dnsrr.pid",
	  :port => 53,
	  :listen_ip => "0.0.0.0",
	  :proto => :udp,
	  :config => '/etc/dnsrr_config.yaml',
      }

opts = GetoptLong.new(
  [ '--config', '-c', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--port', '-p', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--protocol', '-P', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--listen-ip', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--pid-file', '-f', GetoptLong::NO_ARGUMENT ]
)

opts.each do |opt,arg|
  case opt
    when '--config'
      p = Pathname.new(arg)
      unless p.absolute?
	puts "path to file must be absolute!"
	exit(2)
      end
      args[:config] = arg
    when '--port'
      args[:port] = arg.to_i
    when '--protocol'
      args[:proto] = arg.to_sym
    when '--listen-ip'
      args[:listen_ip] = arg
    when '--pid-file'
      args[:pidfile] = arg
  end
end

begin
  pidfile = File.open(args[:pidfile], 'w')
  pidfile.puts($$)
  pidfile.close
rescue Exception => e
  puts e.message
  exit(2)
end

begin
  exps = YAML::load(File.open(args[:config]))
rescue Exception => e
  puts e.message
  exit(2)
end

$R = Resolv::DNS.new
Name = Resolv::DNS::Name
RubyDNS::run_server(:listen => [[args[:proto], args[:listen_ip], args[:port]]]) do
  exps.each do |expression|
    match(expression[:expression], :A) do |dnsmatch|
      dnsmatch[1].respond!("#{expression[:ip]}")
    end
  end
  otherwise do |transaction|
    transaction.passthrough!($R)
  end
end
