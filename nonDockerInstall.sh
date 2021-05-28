#!/bin/sh

DA_ROOTFOLDER=""
CLONE_FOLDER=""
CIAO_INSTALL="./ciao/build/bin"

# installing ciao & scasp
git clone https://github.com/ciao-lang/ciao
cd ciao; ./ciao-boot.sh local-install

export PATH=$CIAO_INSTALL;$PATH
ciao get gitlab.software.imdea.org/ciao-lang/sCASP

# cloning the required docassemble extensions 
git clone https://github.com/smucclaw/docassemble-datatypes 
git clone https://github.com/smucclaw/docassemble-scasp
git clone https://github.com/smucclaw/docassemble-l4
git clone https://github.com/smucclaw/gf-python

/usr/share/docassemble/local3.8/bin/activate # TODO: not the best way of handling this
pip3 install --upgrade \
  ./docassemble-datatypes \
  ./docassemble-scasp \
  ./docassemble-l4


