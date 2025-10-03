FROM docker.io/library/golang:1.16 as build
WORKDIR /go/src/app
COPY . .
RUN make

FROM docker.io/library/debian:latest
COPY *.html ./
COPY *.png ./
COPY *.js ./
COPY *.ico ./
COPY *.css ./
COPY version ./
COPY --from=build /go/src/app/rollouts-demo /rollouts-demo

ARG COLOR
ENV COLOR=${COLOR}
ARG ERROR_RATE
ENV ERROR_RATE=${ERROR_RATE}
ARG LATENCY
ENV LATENCY=${LATENCY}

ENTRYPOINT [ "/bin/bash", "-c" ]
CMD [ "source version && /rollouts-demo" ]
