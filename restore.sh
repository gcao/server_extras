#!/bin/bash

/etc/init.d/apache2 stop

tar xzf ~/backup/mysql-bbs.tgz     -C /var/lib/mysql
tar xzf ~/backup/mysql-ucenter.tgz -C /var/lib/mysql
tar xzf ~/backup/mysql-gocool.tgz  -C /var/lib/mysql

restart mysql
/etc/init.d/apache2 start

tar xzf ~/backup/bbs-images.tgz    -C /data/apps/bbs/current
tar xzf ~/backup/gocool-sgfs.tgz   -C /data/apps/gocool/shared

