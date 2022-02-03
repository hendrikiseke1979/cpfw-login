.PHONY: build test clean

VERSION=$(shell git rev-parse HEAD)

build: cpfw-login_amd64 cpfw-login_darwin cpfw-login.exe cpfw-login_arm64

test: .get-deps *.go
	go test -v

.get-deps: *.go
	go get -t -d -v ./...
	touch .get-deps

clean:
	rm -f .get-deps
	rm -f cpfw-login *_amd64 *_arm64 *_darwin *.exe

cpfw-login_amd64: .get-deps *.go
	 GOOS=linux GOARCH=amd64 go build -o $@ .

cpfw-login_darwin: .get-deps *.go
	GOOS=darwin go build -o $@ .

cpfw-login.exe: .get-deps *.go
	 GOOS=windows GOARCH=amd64 go build -o $@ .

cpfw-login_arm64: .get-deps *.go
	 GOOS=linux GOARCH=arm64 go build -o $@ .
