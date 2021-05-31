#!/bin/sh

activate () {
  . /usr/share/docassemble/local3.8/bin/activate 
}

echo "[1]: Installing ciao & sCASP\n"
git clone https://github.com/ciao-lang/ciao
cd ciao; ./ciao-boot.sh local-install
if [ -x ./ciao/build/bin/ciao-env ] ; then
  eval "$(./ciao/build/bin/ciao-env --sh)"
fi
ciao get gitlab.software.imdea.org/ciao-lang/sCASP

echo "[2]: Cloning the required docassemble extensions\n"
git clone https://github.com/smucclaw/docassemble-datatypes 
git clone https://github.com/smucclaw/docassemble-scasp
git clone https://github.com/smucclaw/docassemble-l4
git clone https://github.com/smucclaw/gf-python

echo "[3]: Installing the required docassemble extensions\n"
activate
pip3 install --upgrade \
  ./docassemble-datatypes \
  ./docassemble-scasp \
  ./docassemble-l4 \
  pgf

echo "[4]: Refreshing docassemble"
python -m docassemble.webapp.create_tables

# TODO 
# echo "[5]: Moving rps.pl & rps.yml to playground for use in testing"


## TODO: Add instructions about apiKeys 
echo "\n\nInstallation complete: \nPlease follow the instructions within README.md on API-keys, before going through the tests & ensuring your installation runs smoothly.\n"
