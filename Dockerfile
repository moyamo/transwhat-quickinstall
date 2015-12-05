From spectrum2/spectrum2:latest
RUN dnf install zlib-devel libjpeg-devel python-devel python-pip git gcc redhat-rpm-config -y &&\
	    pip install --pre e4u protobuf python-dateutil yowsup2 Pillow==2.9.0&&\
	    git clone git://github.com/stv0g/transwhat.git &&\
	    git clone git://github.com/tgalal/yowsup.git &&\
	    cd transwhat &&\
	    git worktree add /opt/transwhat &&\
	    cd .. &&\
	    cd yowsup &&\
	    cp yowsup /opt/transwhat/yowsup &&\
	    cd .. &&\
	    rm -r transwhat &&\
	    rm -r yowsup &&\
	    cd /opt/transwhat &&\
	    rm .git .gitignore&&\
	    dnf remove python-devel git gcc gcc-c++ redhat-rpm-config -y &&\
	    dnf clean all -y
