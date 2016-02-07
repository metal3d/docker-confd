
gncat:
	cd go/gncat/ && \
		export CGO_ENABLED=0 GOOS=linux; \
		go build -a -tags netgo -o gncat .; \
		strip gncat;\
		mv gncat ../../

