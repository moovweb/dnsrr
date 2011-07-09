module Mresolv

  class Parser

    def initialize(resolv="/etc/resolv.conf")
      @config = File.open(resolv).readlines
    end

    def nameservers
      servers = []
      @config.each do |line|
	if line =~ /^nameserver\s+(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/
	  ip = $1.chomp
	  #strip out localhost
	  if ip !~ /^127\./
	    servers << ip
	  end
	end
      end
      servers
    end

    def searchdoms
      doms = []
      @config.each do |line|
	if line =~ /^search\s+(.*)/
	  $1.chomp.split.each { |x| doms << x}
	end
      end
      doms
    end

  end
end

