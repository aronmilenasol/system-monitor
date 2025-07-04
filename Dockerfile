FROM ubuntu:latest

RUN apt-get update && apt-get install -y bash bc procps coreutils dbus && rm -rf /var/lib/apt/lists/*

COPY . /app
WORKDIR /app/bin
RUN chmod +x /app/bin/*.sh /app/modules/*.sh

CMD ["/app/bin/monitor.sh"]
