#!/bin/bash

/etc/init.d/apache2 stop

rm -rf /var/lib/mysql/bbs /var/lib/mysql/ucenter /var/lib/mysql/gocool_production
tar xzf ~/backup/mysql-bbs.tgz     -C /var/lib/mysql
tar xzf ~/backup/mysql-ucenter.tgz -C /var/lib/mysql
tar xzf ~/backup/mysql-gocool.tgz  -C /var/lib/mysql

restart mysql

rm -rf /data/apps/bbs/current/attachments /data/apps/bbs/current/images/avatars/bbsxp
rm -rf /data/apps/gocool/current/shared/system

/etc/init.d/apache2 start

tar xzf ~/backup/bbs-images.tgz    -C /data/apps/bbs/current
tar xzf ~/backup/gocool-sgfs.tgz   -C /data/apps/gocool/shared

