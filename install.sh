#!/bin/bash

# Attempts to install prosody and transwhat

if [[ $# -ne 2 ]]; then
	echo "Usage: $0 <prosody hostname> <transwhat hostname>"
	exit 1
fi

prosodyhost=$1
transwhathost=$2


# Build transwhat image
docker build -t transwhat .

# Make mount points for spectrum
mkdir /opt/spectrum
mkdir /var/lib/spectrum2

sedscript="s/{{{{transwhathost}}}}/$transwhathost/;s/{{{{prosodyhost}}}}/$prosodyhost/" 

# Copy transwhat configuration
sed -e "$sedscript" transwhat.cfg > /opt/spectrum/transwhat.cfg

# Run transwhat
docker run --name="transwhat" -d \
	-v /var/lib/spectrum2:/var/lib/spectrum2 \
	-v /opt/spectrum:/etc/spectrum2/transports \
	--net="host" transwhat

# Make mount points for prosody
mkdir /opt/prosody
mkdir /var/log/prosody

sed -e "$sedscript" prosody.cfg.lua > /opt/prosody/prosody.cfg.lua

docker run -d \
	--name="prosody" \
	--net="host" \
	-v /opt/prosody:/etc/prosody \
	-v /var/log/prosody:/var/log/prosody \
	prosody/prosody:0.9

