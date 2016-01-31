# Simple dockerfile to start confd

[Confd](https://github.com/kelseyhightower/confd) is a nice and powerfull service that reads [CoreOS etcd](https://github.com/coreos/etcd) and apply templates reading values.
This Docker image is very tiny, using busybox that have "netcat" installed.

# Tips

If you want to reload nginx, simply add a volume on the docker sock and send SIGHUP to the right container:

```
docker run -it -v /var/run/docker.sock:/var/run/docker.sock metal3d/etcd -node http://192.168.1.20:4001 ...
```

In you configuration, taking "balancer" as nginx container name:

```
reload_cmd = "echo -e \"POST /containers/balancer/kill?signal=HUP HTTP/1.0\r\n\" | nc -U /var/run/docker.sock"
```


