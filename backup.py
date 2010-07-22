#!/usr/bin/python  

# http://blog.awarelabs.com/2009/painless-amazon-ec2-backup/
#
# To restore, you would have to register it using ec2 tools:
#   ec2-register <your-s3-bucket> /image.manifest.xml
# and then launch it using this command:
#   ec2-run-instances <ami-identifier>
#
# or Amazon AWS Console (http://www.softwarepassion.com/?p=164)

import os
from datetime import date  

pem_file = '/root/.amazon/pk.pem'  
cert_file = '/root/.amazon/cert.pem'  
user_id = '111122223333'
platform = 'i386'
bucket = 'primary_server_backup'  

access_key = 'XXX'
secret_key = 'YYY'
ec2_path = '/usr/local/bin/' #use trailing slash  
  
# DO NOT EDIT BELOW THIS  
  
days = ('sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')  
manifest = days[date.today().weekday()]  
  
step_1 = 'rm -f /mnt/%s*' % (manifest,)  
step_2 = '%sec2-bundle-vol -p %s -d /mnt -k %s -c %s -u %s -r %s' % (ec2_path, manifest, pem_file, cert_file, user_id, platform)  
step_3 = '%sec2-upload-bundle --batch -b %s -m /mnt/%s.manifest.xml -a %s -s %s' % (ec2_path, bucket, manifest, access_key, secret_key)  
  
print step_1  
os.system(step_1)  
print step_2  
os.system(step_2)  
print step_3  
os.system(step_3)