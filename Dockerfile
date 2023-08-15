FROM danielucb/ubuntu:20.04

RUN apt update && apt upgrade -y

RUN apt autoremove -y

RUN apt install -y openjdk-11-jre-headless apt-transport-https software-properties-common
RUN apt install -y php-common php7.4-common php7.4-cli php7.4-curl php7.4-json php7.4-ldap php7.4-mysql php7.4-opcache php7.4-readline php7.4-xml php7.4-mbstring php7.4-xsl php7.4-zip php-apcu php-apcu-bc
RUN apt install -y php7.4-fpm
RUN apt install -y nginx
RUN apt install -y zip

RUN apt install -y wget nano

ADD arquivos/symfony1-1.4.20.tar.gz /opt

RUN ln -s /opt/symfony1-1.4.20/data/bin/symfony /opt/symfony

COPY arquivos/projeto.cnf /etc/nginx/sites-available/projeto.cnf

RUN mkdir -p /etc/nginx/sites-enabled/

RUN ln -s /etc/nginx/sites-available/projeto.cnf /etc/nginx/sites-enabled/projeto.cnf

RUN rm -rf /etc/nginx/sites-enabled/default

WORKDIR /app

EXPOSE 80 8080

CMD ["service php7.4-fpm start && nginx -g daemonoff;"]


#docker build -f Dockerfile -t danielucb/symfony:1.4 .
#docker run -dti --name symfony -v /home/t316048/Documentos/docker/sistemas/symfony/projeto1:/app -p 80:80 -p 8080:8080 danielucb/symfony:1.4 /bin/bash