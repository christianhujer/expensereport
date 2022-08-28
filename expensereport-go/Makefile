.PHONY: all
all:
	go test
	~/go/bin/go-mutesting .

.PHONY: install-deps
install-deps:
	go install github.com/cucumber/godog/cmd/godog@upd-go1.18
	go install github.com/zimmski/go-mutesting/...@latest
