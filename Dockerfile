FROM jhpyle/docassemble

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

USER root
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
