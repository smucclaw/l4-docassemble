FROM jhpyle/docassemble:latest

USER www-data
RUN LC_CTYPE=C.UTF-8 LANG=C.UTF-8 \
bash -c \
"cd /tmp \
&& git clone https://github.com/ciao-lang/ciao \
&& cd ciao; ./ciao-boot.sh local-install "

USER www-data
ENV PATH="/tmp/ciao/build/bin:${PATH}"
RUN LC_CTYPE=C.UTF-8 LANG=C.UTF-8 \
bash -c \
"ciao get gitlab.software.imdea.org/ciao-lang/sCASP"


USER www-data
RUN LC_CTYPE=C.UTF-8 LANG=C.UTF-8 \
bash -c \
"cd /tmp \
&& git clone https://github.com/smucclaw/docassemble-datatypes \
&& git clone https://github.com/smucclaw/docassemble-scasp \
&& git clone https://github.com/smucclaw/docassemble-l4 \
&& source /usr/share/docassemble/local3.8/bin/activate \
&& pip3 install --upgrade \
   /tmp/docassemble-datatypes \
   /tmp/docassemble-scasp \
   /tmp/docassemble-l4 "


USER root
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
