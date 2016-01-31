# Simple dockerfile to start confd

[Confd](https://github.com/kelseyhightower/confd) is a nice and powerfull service that reads [CoreOS etcd](https://github.com/coreos/etcd) and apply templates reading values.

This image provides a command tool to send request to unix socket in HTTP: `gncat`

# Tips

If you want to reload nginx, simply add a volume on the docker sock and send SIGHUP to the right container:

```
docker run -it -v /var/run/docker.sock:/var/run/docker.sock metal3d/etcd -node http://192.168.1.20:4001 ...
```

In you configuration, taking "balancer" as nginx container name:

```
reload_cmd = "gncat POST '/containers/balancer/kill?signal=HUP'"
```

`gncat` is a tiny go program that connect to "docker.sock" and send command in HTTP form. If you mount volume or other socket file, you may use `"-u"` option to change the unix socket path to use.


