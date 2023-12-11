sudo yum install java-1.8.0-openjdk-devel -y
sudo yum install git -y
sudo yum install maven -y
sudo yum install docker -y
sudo systemctl start docker
if [ -d "addrbook" ];
then
    echo "repo is cloned and exists"
    cd /home/ec2-user/addrbook
   #git pull origin addrbook
    git checkout addrbook
else
    git clone https://github.com/dicogit/Test.git
    cd /home/ec2-user/addrbook
    git checkout addrbook
fi
mvn package
sudo cp /home/ec2-user/addrbook/target/addressbook.war /home/ec2-user/addrbook/
sudo docker build -t $1:$2 /home/ec2-user/addrbook/
