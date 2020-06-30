- Create s3 bucket with a lifecycle policy
- Create an AWS access key with the proper IAM role
- Create an SNS topic to send emails if backup fails
- Install aws cli to ec2 https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-install
- Create a crontab entry like this (backup per week):

[root@ip-172-31-44-41 scripts]# crontab -l
####* * * * * /root/scripts/backup_for_crontab.sh &> /tmp/aaa
0 0 * * 0 /root/scripts/backup_for_crontab.sh
