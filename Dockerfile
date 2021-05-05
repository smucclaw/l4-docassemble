FROM jhpyle/docassemble:latest

USER root
RUN sed -i '/echo "initialize finished"/ a\redis-cli set da:api:userid:1:key:RnyeaGLk1ZNsRTfXYYqWMQH1smnxn26s:info \"{\\\"name\\\": \\\"foo\\\", \\\"method\\\": \\\"none\\\", \\\"constraints\\\": []}\"\; echo $? >&2' /usr/share/docassemble/webapp/initialize.sh
RUN sed -i '/echo "initialize finished"/ a\cp /tmp/docassemble-l4/docassemble/l4/data/static/r34.pl /usr/share/docassemble/files/playgroundstatic/1/r34.pl && cp /tmp/docassemble-l4/docassemble/l4/data/static/r34.yml /usr/share/docassemble/files/playgroundstatic/1/r34.yml' /usr/share/docassemble/webapp/initialize.sh
RUN sed -i '/echo "initialize finished"/ a\mkdir -p /usr/share/docassemble/files/playgroundstatic/1' /usr/share/docassemble/webapp/initialize.sh
RUN echo "\nl4:\n  api key: RnyeaGLk1ZNsRTfXYYqWMQH1smnxn26s" >> /usr/share/docassemble/config/config.yml.dist

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
   /tmp/docassemble-l4"


USER root
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
