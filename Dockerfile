FROM ubuntu:latest
#Latest version of Ubuntu
LABEL "Author"="Wessam"
LABEL "Project"="Website"
RUN apt update && apt install git -y
RUN apt install apache2 -y
# install apache and git
CMD ["/usr/sbin/apache2ctl","-D","FORGROUND"]
# run Apache instead of systemctl must from binary
EXPOSE 80
#port
WORKDIR /var/www/html
#doing exec  will attach to that directory
VOLUME /var/log/apache2
#don't want to lose the logs
ADD nano.tar.gz /var/www/html
#COPY nano.tar.gz /var  not copy because copy will not extract
