#

## Server Environment Config

> CentOS for example

### 0. [Linux System Info](https://boxmaking.github.io/linux/systeminfo.html#:~:text=linux%E7%B3%BB%E7%BB%9F%E4%BF%A1%E6%81%AF%E6%9F%A5%E8%AF%A2%E6%95%99%E7%A8%8B%201%202%20GUI%E8%BD%AF%E4%BB%B6%E6%9D%A5%E6%9F%A5%E7%9C%8B%E7%B3%BB%E7%BB%9F%E7%9A%84%E7%A1%AC%E4%BB%B6%E4%BF%A1%E6%81%AF%E2%80%94%E6%9C%80%E7%AE%80%E5%8D%95%20i-nex%20%E6%94%B6%E9%9B%86%E7%A1%AC%E4%BB%B6%E4%BF%A1%E6%81%AF%EF%BC%8C%E5%B9%B6%E4%B8%94%E7%B1%BB%E4%BC%BC%E4%BA%8E%20Windows%20%E4%B8%8B%E6%B5%81%E8%A1%8C%E7%9A%84,-aux%20...%207%208%20%E7%BD%91%E7%BB%9C%E7%9B%B8%E5%85%B3%E5%91%A2%E7%9A%84%E4%BF%A1%E6%81%AF%208.1%20%E6%9F%A5%E7%9C%8B%E7%BD%91%E5%8D%A1%E7%A1%AC%E4%BB%B6%E4%BF%A1%E6%81%AF%20)

```shell
uname -a # 输出系统信息 -a 查看所有 -r 查看内核 -p 处理器 -m 机器硬件信息 -i 硬件平台信息
lscpu
free -m -h # -h 用gb和mb现实便于阅读
```

### 1.  [Install MySQL](https://www.mysqltutorial.org/install-mysql-centos/)

#### Install

```shell
rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo
yum --enablerepo=mysql80-community install mysql-community-server
service mysqld start
grep "A temporary password" /var/log/mysqld.log
[Note] A temporary password is generated for root@localhost: hjkygMukj5+t783
mysql_secure_installation
service mysqld restart
chkconfig mysqld on
mysql -u root -p

```

#### Enable remote access

```mysql
CREATE USER 'root'@'%' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
```

### 2. [Firewell](https://www.ateam-oracle.com/post/opening-ports-in-linux-7-firewalls-for-oracle-analytics-cloud-access-to-database-and-remote-data-connectivity-listeners#:~:text=Compute%20instance%20firewalls%20by%20default%20are%20created%20without,services%20have%20the%20default%20listener%20port%20%281521%29%20open.)

> FirewallD is not running

```shell
systemctl start firewalld # 开启防火墙
firewall-cmd --list-ports # 查看开启端口
firewall-cmd  --permanent --add-port=3306/tcp # 开启3306 
firewall-cmd --reload # 更新防火墙规则
firewall-cmd --zone=public --list-ports # 查询开放的端口

```

### 3. [Redis](https://cloud.tencent.com/developer/article/1938468)

```shell
yum install epel-release
yum install redis
service redis start # 启动redis
chkconfig redis on # 开机启动

redis-cli shutdown # stop
```

[update version](https://computingforgeeks.com/how-to-install-latest-redis-on-centos-rhel/)

```shell
sudo yum -y update
sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum --enablerepo=remi install redis
rpm -qi redis
sudo systemctl enable --now redis #  enable the service to start on system boot.

sudo vim /etc/redis.conf

bind {server_ip}


systemctl status  redis
sudo ss -tunelp | grep 6379

sudo systemctl restart redis # restart
redis-cli shutdown           # stop
```

### 4. [Nginx](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-centos-7)

```shell
sudo yum install epel-release
sudo yum install nginx
sudo systemctl start nginx
sudo systemctl status nginx
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

sudo systemctl enable nginx

vim /etc/nginx/nginx.conf
nginx -t
nginx -s reload

sudo systemctl start nginx  # start
sudo systemctl stop nginx   # stop
sudo service nginx restart  # restart
```

### 5. [Install Java](https://linuxize.com/post/install-java-on-centos-7/)

```shell
sudo yum install java-11-openjdk-devel
java -version
```
