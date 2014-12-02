FROM mongo:latest
MAINTAINER Craig Odell <odell.craig@gmail.com>

RUN apt-get update && \
    apt-get install -y pwgen && \
    apt-get clean

ENV AUTH yes

# Add run scripts
ADD go.sh /go.sh
ADD auth.sh /auth.sh
RUN chmod 755 ./*.sh

EXPOSE 27017
EXPOSE 28017

CMD ["/go.sh"]
