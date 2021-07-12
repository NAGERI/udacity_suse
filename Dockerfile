FROM golang:alpine

WORKDIR /go/src/app

ADD . .

# COPY . /go/src/app

RUN go mod init && go build -o helloworld

EXPOSE 6111

CMD ["./helloworld"]