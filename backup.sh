#!/bin/bash

rm -rf ~/backup
mkdir ~/backup
cd ~/backup
tar czf mysql-bbs.tgz -C /var/lib/mysql bbs
tar czf mysql-gocool.tgz -C /var/lib/mysql gocool_production
tar czf mysql-ucenter.tgz -C /var/lib/mysql ucenter

tar czf bbs-images.tgz -C /data/apps/bbs/current attachments images/avatars/bbsxp
tar czf gocool-sgfs.tgz -C /data/apps/gocool/shared system

