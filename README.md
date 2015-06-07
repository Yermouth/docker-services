
### Build Docker image

``` 
docker build -t your_services .
```

### Start the container

- On Linux

``` 
docker run -p 2181:2181 -p 9092:9092 -p 3000:3000 -p 3001:3001 -p 3002:3002 -p 3003:3003 --env KAFKA_HOST=localhost --env KAFKA_PORT=9092 -t your_services  
``` 

- On OSX

``` 
docker run -p 2181:2181 -p 9092:9092 -p 3000:3000 -p 3001:3001 -p 3002:3002 -p 3003:3003 --env KAFKA_HOST=`boot2docker ip` --env KAFKA_PORT=9092 -t your_services  
```

Alternatively, drop into a bash instead of supervisord


```
docker run -p 2181:2181 -p 9092:9092 -p 3000:3000 -p 3001:3001 -p 3002:3002 -p 3003:3003 --env KAFKA_HOST=localhost --env KAFKA_PORT=9092 -it --rm your_services /usr/bin/launch.sh -bash  
```
