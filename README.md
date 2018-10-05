## How to run
```bash
docker run -d -p 5010:80 --name g-dash \
    -v your_path_to/datadir:/opt/gulden/datadir \
    -v your_path_to/config.php:/var/www/html/config/config.php \
    -e GULDEN_MAXCONNECTIONS=60 \
    -e GULDEN_RPCUSER=gulden \
    -e GULDEN_RPCPASSWORD=randompassword \
    ishouldcreatethis
```
