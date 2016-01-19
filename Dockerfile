FROM debian:jessie
MAINTAINER Hardware <contact@meshup.net>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    postfix postfix-mysql \
    dovecot-core dovecot-imapd dovecot-lmtpd dovecot-mysql dovecot-sieve dovecot-managesieved \
    opendkim opendkim-tools opendmarc \
    amavisd-new spamassassin spamc clamav-milter \
    supervisor openssl rsyslog \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ADD rootfs /
RUN chmod +x /usr/local/bin/*

VOLUME /ssl /var/mail /var/lib/dovecot /etc/opendkim/keys
EXPOSE 25 143 587 993 4190

CMD ["/usr/local/bin/startup"]