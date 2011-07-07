#!/usr/bin/env ruby

require 'rubygems' if RUBY_VERSION < "1.9"
require "daemons"

Daemons.run(File.join(File.dirname(__FILE__), '..','lib','dnsrr.rb'))

