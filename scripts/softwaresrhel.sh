#!/usr/bin/env bash
echo "*********subscription*****start********"
sudo subscription-manager register --username='laxmangandhi' --password='Jul@2021' --name=packer-rhel7-$(date +%Y%m%d)-${RANDOM}
sudo subscription-manager attach --pool='8a85f9a07aaf843c017abea365cb2210'
sudo subscription-manager repos --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-optional-rpms
echo "*********subscription*****stop********"
sudo yum install wget -y
sudo yum update -y
echo "*********GUI*****start********"
sudo yum groupinstall "Server with GUI" -y
sudo ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target
sudo systemctl get-default
echo "*********GUI*****stop********"
echo "*********Java*****start********"
sudo yum install java-11-openjdk-devel -y 
echo "*********Java*****stop********"
echo "*********Git*****start********"
sudo yum install git -y
echo "*********git*****stop********"
 
echo "*********eclipse*****start********"
sudo wget http://ftp.jaist.ac.jp/pub/eclipse/technology/epp/downloads/release/oxygen/3a/eclipse-java-oxygen-3a-linux-gtk-x86_64.tar.gz
sudo tar -zxvf eclipse-java-oxygen-3a-linux-gtk-x86_64.tar.gz -C /opt
sudo ln -sf /opt/eclipse/eclipse /usr/bin/eclipse
sudo bash -c 'cat << EOF > /usr/share/applications/eclipseide.desktop  
[Desktop Entry]
Encoding=UTF-8
Name=Eclipse IDE
Comment=Eclipse IDE
Exec=/usr/bin/eclipse
Icon=/opt/eclipse/icon.xpm
Categories=Application;Development;Java;IDE
Version=1.0
Type=Application
Terminal=0
EOF'
echo "*********eclipse*****stop********"

echo "*********Spring Tools Suite (STS)*****start********"
sudo wget https://dist.springsource.com/release/STS/3.9.12.RELEASE/dist/e4.13/spring-tool-suite-3.9.12.RELEASE-e4.13.0-linux-gtk-x86_64.tar.gz
sudo mv spring-tool-suite-3.9.12.RELEASE-e4.13.0-linux-gtk-x86_64.tar.gz /opt
cd /opt
sudo tar -zxvf spring-tool-suite-3.9.12.RELEASE-e4.13.0-linux-gtk-x86_64.tar.gz
sudo ln -sf /opt/sts-bundle/sts-3.9.12.RELEASE/STS /usr/local/bin/sts
sudo bash -c 'cat << EOF > /usr/share/applications/stsLauncher.desktop
[Desktop Entry]
Name=Spring Tool Suite
Comment=Spring Tool Suite 3.9.12
Exec=/opt/sts-bundle/sts-3.9.12.RELEASE/STS
Icon=/opt/sts-bundle/sts-3.9.12.RELEASE/icon.xpm
StartupNotify=true
Terminal=false
Type=Application
Categories=Application;Development;IDE;Java;
EOF'
echo "*********Spring Tools Suite (STS)*****stop********"

echo "*********IntelliJ IDEA*****start********"
sudo wget https://download.jetbrains.com/idea/ideaIC-2021.2.tar.gz
sudo mv ideaIC-2021.2.tar.gz /opt
cd /opt
sudo tar -zxvf ideaIC-2021.2.tar.gz
sudo mv idea-IC* idea
#sudo ln -sf /opt/sts-bundle/sts-3.9.12.RELEASE/STS /usr/local/bin/sts
sudo bash -c 'cat << EOF > /usr/share/applications/jetbrains-idea.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA Ultimate Edition
Icon=/opt/idea/bin/idea.svg
Exec=/opt/idea/bin/idea.sh
Comment=Capable and Ergonomic IDE for JVM
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-idea
EOF'
echo "*********IntelliJ IDEA*****End********"

echo "*********soapUI*****start********"
sudo wget https://s3.amazonaws.com/downloads.eviware/soapuios/5.4.0/SoapUI-5.4.0-linux-bin.tar.gz
sudo tar -xzf SoapUI-5.4.0-linux-bin.tar.gz -C /opt/
sudo ln -s /opt/soapui-5.4.0/bin/soapui.sh /usr/bin/soapui
sudo bash -c 'cat << EOF > /usr/share/applications/soapui.desktop
[Desktop Entry]
Version=5.4.0
Type=Application
Name=Soap UI
Icon=/opt/SoapUI-5.4.0/bin/SoapUI-Spashscreen.png
Exec=/opt/SoapUI-5.4.0/bin/soapui.sh
Comment=Capable and Ergonomic IDE for JVM
Categories=Development
Terminal=false
X-Ayatana-Desktop-Shortcuts=NewWindow
EOF'
echo "*********soapUI*****stop********"

echo "*********postman*****start********"
sudo wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz
sudo tar -xzf postman-linux-x64.tar.gz -C /opt/
#sudo mv Postman /opt
sudo ln -sf /opt/Postman/Postman /usr/local/bin/postman
sudo bash -c 'cat << EOF > /usr/share/applications/Postman.desktop
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/app/Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOF'
echo "*********postman*****end********"

echo "*********azure cli*****start********"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo
sudo yum install azure-cli -y
az --version
echo "*********azure cli*****stop********"

echo "*********MAVEN*****start********"
sudo wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
sudo tar -xzvf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.6.3 /opt/maven
sudo bash -c 'cat << EOF > /etc/profile.d/maven.sh
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.12.0.7-0.el7_9.x86_64
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export PATH=/opt/maven/bin:${PATH}
EOF'
sudo chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
mvn -version
echo "*********MAVEN*****stop********"

echo "*********gradel*****start********"
sudo wget https://services.gradle.org/distributions/gradle-6.4.1-bin.zip -P /tmp
sudo unzip -d /opt/gradle /tmp/gradle-*.zip
sudo bash -c 'cat << EOF > /etc/profile.d/gradle.sh
export GRADLE_HOME=/opt/gradle/gradle-6.4.1
export PATH=/opt/gradle/gradle-6.4.1/bin:${PATH}
EOF'
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
gradle -v
echo "*********gradle*****stop********"

echo "*******putty*****start********"
sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum update -y
sudo yum install putty -y -y
echo "*******putty*****stop********"

echo "*****snapd****start********"
sudo yum install snapd -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
echo "*****snapd****stop********"

echo "*****npm and nodejs****start********"
#sudo yum install npm -y #npm -version
sudo yum install nodejs -y #node -v
echo "*****npm and nodejs****stop********"

echo "*****yarn****start********"
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
sudo yum install yarn -y #yarn version
echo "*****yarn****stop**********"

echo "*********cf-cli*****start********"
sudo wget -O /etc/yum.repos.d/cloudfoundry-cli.repo https://packages.cloudfoundry.org/fedora/cloudfoundry-cli.repo
sudo yum install cf-cli -y #cf -v
#sudo snap install cf-cli
echo "*********cf-cli*****stop********"

echo "*********docker*****start********"
sudo yum install -y docker device-mapper-libs device-mapper-event-libs
sudo systemctl enable --now docker.service
echo "*********docker*****stop********"

echo "******visual studio code*****start********"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo bash -c 'cat << EOF > /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF'
sudo yum check-update
sudo yum install code -y
echo "*****visual studio code*****stop********"

echo "*******Github-desktop*****start********"
sudo rpm --import https://packagecloud.io/shiftkey/desktop/gpgkey
sudo sh -c 'echo -e "[shiftkey]\nname=GitHub Desktop\nbaseurl=https://packagecloud.io/shiftkey/desktop/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/shiftkey/desktop/gpgkey" > /etc/yum.repos.d/shiftkey-desktop.repo'
sudo yum install github-desktop -y -y 
echo "********Github-desktop******stop********"

echo "*******Oracle instantclient******start********"
sudo yum install libaio -y 
sudo rpm -ivh https://download.oracle.com/otn_software/linux/instantclient/211000/oracle-instantclient-basic-21.1.0.0.0-1.x86_64.rpm
echo "*******oracle instantclient******stop********"

sudo systemctl restart snapd.seeded.service
echo "*********android*****start********"
sudo snap install android-studio --classic
echo "*********android*****stop********"

echo "*********notepad*****start********"
sudo snap install notepad-plus-plus   
echo "*********notepad*****stop********"

#Gradle
#echo "export PATH=/opt/gradle/bin:${PATH}" | tee /etc/profile.d/gradle.sh

