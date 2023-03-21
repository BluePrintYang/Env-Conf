## Ubuntu Environment

### [Install Nginx](https://ubuntu.com/tutorials/install-and-configure-nginx)

```shell
sudo apt update
sudo apt install nginx
```

### Config own website

```shell
cd /var/www
sudo mkdir tutorial
cd tutorial
sudo "${EDITOR:-vi}" index.html
```

> create `index.html` file

```html
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Hello, Nginx!</title>
</head>
<body>
    <h1>Hello, Nginx!</h1>
    <p>We have just configured our Nginx web server on Ubuntu Server!</p>
</body>
</html>
```

> add config

```shell
cd /etc/nginx/sites-enabled
sudo "${EDITOR:-vi}" tutorial
```

```nginx
server {
       listen 81;
       listen [::]:81;

       server_name example.ubuntu.com;

       root /var/www/tutorial;
       index index.html;

       location / {
               try_files $uri $uri/ =404;
       }
}
```

> visit http://localhost:81