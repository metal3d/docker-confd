# Simple dockerfile to start confd

[Confd](https://github.com/kelseyhightower/confd) is a nice and powerfull service that reads [CoreOS etcd](https://github.com/coreos/etcd) and apply templates reading values.

This image provides a command tool to send request to unix socket in HTTP: `gncat` - it is developed in Go and build with "netgo" (no need external library).

# Usage

You should mount a configuration directory to "/etc/confd" with:

- `/etc/confd/templates/` directory whith templates
- `/etc/confd/conf.d/` directory with ".toml" files

The default "entrypoint" is "confd" command so you can pass arguments directly after the docker image in your command line. Argument to set is, at least, the backend address if you don't use host network.

Example:
```
docker run -it --rm \
-v $(pwd)/confd:/etc/confd \
metal3d/confd -node 192.168.100.1:4001 
```

# Tips

## Reload command

If you want to reload nginx, simply add a volume from docker socket and send SIGHUP to the right container:

```bash
docker run --rm -it \
-v /var/run/docker.sock:/var/run/docker.sock \
metal3d/etcd -node 192.168.1.20:4001 ...
```

In you configuration, taking "balancer" as nginx container name, your "nginx.toml" file (`/etc/confd/conf.d/nginx.toml`):

```ini
[template]
src = "nginx.conf"
dest = "/etc/nginx/nginx.conf"
keys = [
    "/nginx/hosts"
]
reload_cmd = "gncat POST '/containers/balancer/kill?signal=HUP'"
```

See gncat usage section.

## Use Watch or Interval

If you need to have real-time changes, you may use "-watch" argument from confd command.

```bash
docker run --rm -it \
-v $(pwd)/confd:/etc/confd \
metal3d/confd -node 192.168.1.1:4001 -watch
```

You may also use "interval" (that is default to 600 seconds) that is the default behaviour if you don't give "-wath" argument. To change value:


```bash
# check value every 5 seconds
docker run --rm -it \
-v $(pwd)/confd:/etc/confd \
metal3d/confd -node 192.168.1.1:4001 -interval 5
```


# Gncat

Gncat command can be used like this:

```bash
# by default, /var/run/docker.sock is used
gncat GET|POST|PUT... "/request/query/string"
# to use another socket file
gncat -u  /path/to/file.sock GET|POST|PUT... "/request/query/string"
```

Use the Makefile that is provided in metal3d/docker-confd repository to build gncat.

