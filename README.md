# Simple dockerfile to start confd

[Confd](https://github.com/kelseyhightower/confd) is a nice and powerfull service that reads [CoreOS etcd](https://github.com/coreos/etcd) and apply templates reading values.

This image provides a command tool to send request to unix socket in HTTP: `gncat` - it is developed in Go and build with "netgo" (no need external library).

# Tips

If you want to reload nginx, simply add a volume on the docker sock and send SIGHUP to the right container:

```bash
docker run -it -v /var/run/docker.sock:/var/run/docker.sock metal3d/etcd -node http://192.168.1.20:4001 ...
```

In you configuration, taking "balancer" as nginx container name:

```
reload_cmd = "gncat POST '/containers/balancer/kill?signal=HUP'"
```

`gncat` is a tiny go program that connect to "docker.sock" and send command in HTTP form. If you mount volume or other socket file, you may use `"-u"` option to change the unix socket path to use.


# Gncat

Gncat command can be used like this:

```bash
# by default, /var/run/docker.sock is used
gncat GET|POST|PUT... "/request/query/string"
# to use another socket file
gncat -u  /path/to/file.sock GET|POST|PUT... "/request/query/string"
```
