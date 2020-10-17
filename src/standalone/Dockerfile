FROM phusion/baseimage:bionic-1.0.0

MAINTAINER support@diladele.com

# set configuration variables
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV DSDNS_UI_VER 0.16.0.F48A
ENV DSDNS_VER 0.16.0.2D26
ENV ARCH amd64
ENV OSNAME ubuntu18

# Updating the OS with the latest fixes
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN apt-get install -y --no-install-recommends apt-utils && \
    apt install -y curl cron iproute2 python3-pip python3-dev \
                   libjpeg-dev zlib1g-dev libldap2-dev libsasl2-dev \
                   libssl-dev sudo dnsutils libatlas-base-dev && \
    # install django and all other modules
    pip3 install django==3.1.1 pytz tld requests pandas PyYAML PyOpenSSL psutil && \
    # update timezone to utc
    echo UTC >/etc/timezone && ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    # there are some bugs in Ubuntu 18 and Python3 environment concerning the LDAP module,
    # so we fix them by removing obsolete ldap modules and reinstalling the correct one
    # download and install diladele packages
    curl http://packages.diladele.com/dnssafety-ui/${DSDNS_UI_VER}/${ARCH}/release/${OSNAME}/dnssafety-ui-${DSDNS_UI_VER}_$ARCH.deb -o dnssafety-ui-${DSDNS_UI_VER}_$ARCH.deb && \
    curl http://packages.diladele.com/dnssafety-core/${DSDNS_VER}/${ARCH}/release/ubuntu18/dnssafety-${DSDNS_VER}_${ARCH}.deb -o dnssafety-${DSDNS_VER}_${ARCH}.deb && \
    dpkg --install dnssafety-${DSDNS_VER}_${ARCH}.deb && \
    dpkg --install dnssafety-ui-${DSDNS_UI_VER}_${ARCH}.deb && \
    # make sure there are default log files
	mkdir -p /var/log/dnssafety && \
    touch /opt/dnssafety/var/log/access.log && \
    touch /opt/dnssafety/var/log/cron_update.log && \
    touch /opt/dnssafety-ui/var/log/cron_report.log && \
    chown -R daemon:daemon /opt/dnssafety-ui && \
    # install apache, wsgi and sqllite
    apt-get -y install apache2 libapache2-mod-wsgi-py3 sqlite && \
    # the dsdnsd daemon will listen on ports 80, 443 for a 'access blocked page'
    # so UI will be running on port 8000, it is already set so in
    # /etc/apache2/sites-available/dnssafety-ui.conf but we also need to set
    # apache to listen on port 8000 instead of port 80 (which is taken by dsdnsd)
    sed -i 's/Listen 80/Listen 8000/g' /etc/apache2/ports.conf && \
    a2dissite 000-default && \
    a2ensite dnssafety-ui && \
    mkdir -p /var/run/apache2 && \
    # make sure timezone and network management UI is disabled in docker
    sed -i "s/def can_manage_network(self):/def can_manage_network(self):\n        return False/" /opt/dnssafety-ui/var/console/node/models.py && \
    sed -i "s/def can_manage_timezone(self):/def can_manage_timezone(self):\n        return False/" /opt/dnssafety-ui/var/console/node/models.py && \
    # perform cleanup
    apt-get remove -y curl && \
    apt-get clean && \
    rm -rf dnssafety-${DSDNS_VER}_${ARCH}.deb dnssafety-ui-${DSDNS_UI_VER}_${ARCH}.deb && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    # too many hardlinks in phusion-basimage for crontab
    touch /etc/crontab

# copy required files
COPY contents/ /

# reset owner of installation path
RUN chmod +x /opt/dnssafety/bin/* && \
    chmod +x /etc/my_init.d/firstrun.sh && \
    chmod +x /etc/service/dsdnsd/run /etc/service/apache2/run

CMD ["/sbin/my_init"]
