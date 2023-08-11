FROM archlinux:base

WORKDIR /test

COPY [".", "/test"]

ENTRYPOINT ["tail"]

CMD ["-f", "/dev/null"]
