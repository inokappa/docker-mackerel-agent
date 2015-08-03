# docker-mackerel-agent
Docker image for mackerel-agent

## how to use

### overview

1. docker build
2. Check or Get API key(Please visit your mackrel dashboard.)
3. docker run

### docker build

```
docker build -t your_name/docker-mackerel-agent .
```

### Check or Get API key

1. Please visit your mackrel dashboard.
2. Please visit your Organization Page.
3. Check API key Tab.

### docker run

```
docker run \
  -h `hostname` \
  --name=mackerel-agent \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/mackerel-agent/:/var/lib/mackerel-agent/ \
  -v /proc/mounts:/host/proc/mounts:ro \
  -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro \
  -e 'apikey=${your_api_key}' \
your_name/docker-mackerel-agent
```
