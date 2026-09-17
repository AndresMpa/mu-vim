FROM docker.io/library/golang:1.23-alpine

WORKDIR /src/current/tests
ENV CGO_ENABLED=0
ENV MUVIM_CURRENT=/src/current
ENV MUVIM_MINI=/src/mini
ENV MUVIM_VIMSCRIPT=/src/vimscript

CMD ["go", "test", "-count=1", "-parallel", "8", "."]
