package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"net"
	"net/http"
	"os"
)

var (
	sock = "/var/run/docker.sock"
)

func unixdialer(proto, addr string) (net.Conn, error) {
	return net.Dial("unix", sock)
}

func usage() {
	fmt.Fprintf(os.Stderr, "usage: %s GET|POST|PUT... /query/string\n", os.Args[0])
	flag.PrintDefaults()
	os.Exit(2)
}

func main() {

	flag.StringVar(&sock, "u", sock, "Unix socket to connect")
	flag.Usage = usage
	flag.Parse()

	args := flag.Args()
	t := &http.Transport{
		Dial: unixdialer,
	}
	c := http.Client{Transport: t}

	req, _ := http.NewRequest(args[0], "http://d/"+args[1], nil)

	resp, err := c.Do(req)
	if err != nil {
		log.Fatal(err)
	}
	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(string(b))
}
