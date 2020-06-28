#!/bin/bash

sed -i 's/#NTP=/NTP=time.cloudflare.com/g' /etc/systemd/timesyncd.conf
sed -i 's/#FallbackNTP=/FallbackNTP=/g' /etc/systemd/timesyncd.conf
sed -i 's/#RootDistanceMaxSec=/RootDistanceMaxSec=/g' /etc/systemd/timesyncd.conf
sed -i 's/#PollIntervalMinSec=/PollIntervalMinSec=/g' /etc/systemd/timesyncd.conf
sed -i 's/#PollIntervalMaxSec=/PollIntervalMaxSec=/g' /etc/systemd/timesyncd.conf