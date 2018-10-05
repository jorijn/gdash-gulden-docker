# G-DASH Docker image with Gulden daemon
I wanted to run a Gulden instance with a Witness node. I found G-DASH to be a web interface for this purpose. There was no 
Docker image available to run it on my own Synology NAS so I created one. It should run fine on any Linux based OS but it 
was tested on a Synology DS218+ and Mac OS 10.12.  

## How to run
```bash
docker run -d -p 5010:80 --name g-dash-gulden \
    -v your_path_to/datadir:/opt/gulden/datadir \
    -v your_path_to/config.php:/var/www/html/config/config.php \
    -e GULDEN_MAXCONNECTIONS=60 \
    -e GULDEN_RPCUSER=gulden \
    -e GULDEN_RPCPASSWORD=randompassword \
    jorijn/gdash-gulden
```

After it's started, you can find G-DASH on http://IPOFYOURDOCKERHOST:5010/

## The configuration file
Either you mount an empty file or download [this](https://github.com/Bastijn/g-dash/blob/master/config/config_sample.php) 
one as an example. Be sure it's writable on your Docker host. G-DASH will manage the configuration from within the container.  

## Setting up G-DASH
```
GuldenD location: /opt/gulden/gulden/
Data location: /opt/gulden/datadir/
RPC username: See docker run command
RPC password: See docker run command
Host address: 127.0.0.1
Host port: 9232
```
