From spectrum2/spectrum2:latest
RUN dnf install zlib-devel libjpeg-devel python-devel python-pip git gcc redhat-rpm-config -y &&\
	    pip install --pre e4u protobuf python-dateutil yowsup2 &&\
	    git clone git://github.com/stv0g/transwhat.git &&\
	    cd transwhat &&\
	    git worktree add /opt/transwhat &&\
	    cd .. &&\
	    rm -r transwhat &&\
	    cd /opt/transwhat &&\
	    rm .git .gitignore&&\
	    dnf remove python-devel git gcc gcc-c++ redhat-rpm-config -y &&\
	    dnf clean all -y
