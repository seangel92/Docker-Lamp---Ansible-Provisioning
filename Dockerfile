FROM ubuntu:latest
MAINTAINER Angel Rubio <seangel1992@gmail.com>

# Hacer un upgrade y un update
RUN apt-get update 

# Instalación de paquetes
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install vim mysql-client mysql-server apache2 libapache2-mod-php5 pwgen python-setuptools vim-tiny php5-mysql

# Implementación de Ansible
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade
RUN apt-get -y autoremove
RUN sudo easy_install pip
RUN sudo pip install -U ansible
ADD inventory /etc/ansible/hosts
ADD ./ /tmp/
WORKDIR /tmp/
RUN ansible-playbook -s site.yml -c local

# Encender supervisor y añadir cosas del directoria actual, al contenedor
RUN easy_install supervisor
ADD ./start.sh /start.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD ./supervisord.conf /etc/supervisord.conf

# Copiar las paginas webs con su configuración
COPY  www/  /var/www/
COPY  sites-available/  /etc/apache2/sites-available/

# Cambiar permisos de los archivos
RUN chmod 755 /start.sh
RUN chmod 755 /etc/apache2/foreground.sh

# Configuración del apache2
COPY  apache2.conf  /etc/apache2/apache2.conf

# Validar las nuevas webs y restart apache2
COPY  sites-available/ /etc/apache2/sites-enabled/
RUN service apache2 restart

# Abrir los puertos que necesites
EXPOSE 80

CMD ["/bin/bash", "/start.sh"]
