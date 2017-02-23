FROM scratch

ADD . /
RUN ["/bin/busybox", "--install", "-s"]

CMD ["/setup-gateway.sh"]
