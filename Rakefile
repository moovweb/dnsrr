task :default => :build_gem

def run_command(cmd)
  cmdrun = IO.popen(cmd)
  output = cmdrun.read
  cmdrun.close
  if $?.to_i > 0
    puts "count not run #{cmd}, it returned an error #{output}"
    exit 2
  end
  puts "OK: ran command #{cmd}"
end


desc 'build the gem'
task :build_gem do
  run_command("gem build dnsrr.gemspec")
end
