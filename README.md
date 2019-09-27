# eGulden on Docker

Docker image that runs eGulden deamon and cli interface.

## Usage

Run the image:

```shell script
docker run -v ./egulden:/egulden --name=eguldend -d \
    -p 11015:11015 -p 21015:21015 \
    registry.gitlab.com/electronic-gulden-foundation/eguldend-docker:latest
```

Check that the image is running:

```shell script
docker ps
```

Make sure everything is working correctly:

``` shell script
docker logs -f eguldend
```
