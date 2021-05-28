#!/bin/sh

DA_ROOTFOLDER=""
CLONE_FOLDER=""
CIAO_INSTALL="./ciao/build/bin"

activate () {
  . /usr/share/docassemble/local3.8/bin/activate 
}

# installing ciao & scasp
git clone https://github.com/ciao-lang/ciao
cd ciao; ./ciao-boot.sh local-install

if [ -x /tmp/l4-docassemble/ciao/build/bin/ciao-env ] ; then
  eval "$(/tmp/l4-docassemble/ciao/build/bin/ciao-env --sh)"
fi
ciao get gitlab.software.imdea.org/ciao-lang/sCASP

# cloning the required docassemble extensions 
git clone https://github.com/smucclaw/docassemble-datatypes 
git clone https://github.com/smucclaw/docassemble-scasp
git clone https://github.com/smucclaw/docassemble-l4
git clone https://github.com/smucclaw/gf-python

activate
pip3 install --upgrade \
  ./docassemble-datatypes \
  ./docassemble-scasp \
  ./docassemble-l4


