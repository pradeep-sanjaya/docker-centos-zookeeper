# centos-zookeeper
Docker container image with
- Oracle Java 1.8.0_131
- Apache Zookeeper 3.6.1
- Container base centos image size is 237MB
- Final image size is 637MB

## Steps
1. Mount host /data/zookeeper to the guest os
2. Expose 2181, 2888, 3888 ports to host os

## Build
```
docker build -t ngpsanjaya/centos-zookeeper:1.0.0 .
```

## Run docker containers
### Run a single node
docker run --name zookeeper -v /data/zookeeper:/data/zookeeper -e MY_ID=1 -p 2181:2181 -p 2888:2888 -p 3888:3888 -d ngpsanjaya/centos-zookeeper:1.0.0

### Run three ensembles cluster
### On host1 172.0.0.1
```
docker run --name zookeeper -v /data/zookeeper:/data/zookeeper -e MY_ID=1 -e ENSEMBLE_HOST_NAMES=172.0.0.1,172.0.0.2,172.0.0.3 -p 2181:2181 -p 2888:2888 -p 3888:3888 -d ngpsanjaya/centos-zookeeper:1.0.0
```

### On host2 172.0.0.2
```
docker run --name zookeeper -v /data/zookeeper:/data/zookeeper -e MY_ID=2 -e ENSEMBLE_HOST_NAMES=172.0.0.1,172.0.0.2,172.0.0.3 -p 2181:2181 -p 2888:2888 -p 3888:3888 -d ngpsanjaya/centos-zookeeper:1.0.0
```

### On host3 172.0.0.3
```
docker run --name zookeeper -v /data/zookeeper:/data/zookeeper -e MY_ID=3 -e ENSEMBLE_HOST_NAMES=172.0.0.1,172.0.0.2,172.0.0.3 -p 2181:2181 -p 2888:2888 -p 3888:3888 -d ngpsanjaya/centos-zookeeper:1.0.0
```

## Verify
```
telnet 172.17.0.1 2181
telnet 172.17.0.2 2181
telnet 172.17.0.3 2181
```

### Connect to remote zookeeper from local zookeeper installation, with zkCli.sh

#### Connect to a single node
```
./bin/zkCli.sh -server 172.0.0.1:2181
```

#### Connect to three ensembles cluster
```
./bin/zkCli.sh -server 172.0.0.1:2181,172.0.0.2:2181,172.0.0.3:2181
```