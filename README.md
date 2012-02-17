Installing
==========

Run: 

    bundle install


Setting up
==========

1) create a config file

    cp config/example.yaml /etc/dnsrr_config.yaml

edit it to meet your needs

2) run with default configs

    rvmsudo bin/dnsrr_control  start

3) pass arguments

    rvmsudo bin/dnsrr_control start -- --config /home/user/test/config.yaml

4) run in the foreground - gets errors

    rvmsudo bin/dnsrr_control  run

5) Available arguments

    --config 	= takes absolute path to a config file default is /etc/dnsrr_config.yaml
    --port   	= listen on a different port than the default 53
    --protocol 	= change the protocol from the default udp
    --pid-file	= write a pidfile default is /tmp/dnsrr.pid
    --listen-ip	= default is 0.0.0.0 ( all interfaces )

6) Set 127.0.0.1 as your primary nameserver in your network settings

----------------------------------------------------------------

Big thanks to the rubydns gem from [https://github.com/ioquatix/rubydns](https://github.com/ioquatix/rubydns)
