FROM golang:1.13-buster as build

WORKDIR /go/src/app
ADD . /go/src/app

ENV GOPATH=/go/src/app
RUN go build -o /go/bin/app gocsp-responder/main

# Now copy it into our base image.
FROM gcr.io/distroless/base-debian10
COPY --from=build /go/bin/app /
ENTRYPOINT ["/app","-stdout"]
