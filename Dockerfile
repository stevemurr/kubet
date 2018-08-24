FROM golang:alpine3.8 as builder
RUN apk update && apk add git
COPY . /go/src/kubet
RUN go get github.com/labstack/echo
RUN go get github.com/labstack/echo/middleware
WORKDIR /go/src/kubet/cmd/demo  
RUN go build demo.go

FROM golang:alpine3.8
WORKDIR /root/
COPY --from=builder /go/src/kubet/cmd/demo/demo .
ENTRYPOINT [ "./demo" ]