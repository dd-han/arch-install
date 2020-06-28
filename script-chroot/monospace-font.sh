#!/bin/bash

cp config-system/01-monospace-font.conf /etc/fonts/conf.avail
ln -s /etc/fonts/conf.avail/01-monospace-font.conf /etc/fonts/conf.d/01-monospace-font.conf 