sudo subscription-manager register --username='laxmangandhi' --password='Jul@2021' --name=packer-rhel7-$(date +%Y%m%d)-${RANDOM}
sudo subscription-manager attach --pool='8a85f9a07aaf843c017abea365cb2210'
sudo yum update -y
sudo yum install java-11-openjdk-devel -y 
sudo yum install git -y
sudo  yum groupinstall "Server with GUI" -y 
sudo ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target