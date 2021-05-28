#!/bin/sh

DA_ROOTFOLDER=""
CLONE_FOLDER=""

# installing ciao & scasp
git clone https://github.com/ciao-lang/ciao
cd ciao; ./ciao-boot.sh local-install


# cloning the required docassemble extensions 
git clone https://github.com/smucclaw/docassemble-datatypes 
git clone https://github.com/smucclaw/docassemble-scasp
git clone https://github.com/smucclaw/docassemble-l4
git clone https://github.com/smucclaw/gf-python

pip3 install --upgrade \
  ./docassemble-datatypes \
  ./docassemble-scasp \
  ./docassemble-l4


