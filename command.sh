# Setup SSH
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys


# Get Hadoop
wget https://mirrors.estointernet.in/apache/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz
tar -xvf hadoop-3.3.0.tar.gz

# Install java
sudo apt install -y openjdk-8-jre-headless

# Need to setup some export
# Also put it in your bash profile
# vi .bashrc
# source .bashrc
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export HADOOP_HOME=/home/ubuntu/hadoop-3.3.0
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$JAVA_HOME/bin
export HDFS_NAMENODE_USER="ubuntu"
export HDFS_DATANODE_USER="ubuntu"
export HDFS_SECONDARYNAMENODE_USER="ubuntu"
export YARN_RESOURCEMANAGER_USER="ubuntu"
export YARN_NODEMANAGER_USER="ubuntu"


# Update name of cluster
sudo echo "0.0.0.0 hadoop.cluster" >> /etc/hosts

# Make required dir
mkdir -p /home/ubuntu/hadoop-data/dfsdata/namenode
mkdir -p /home/ubuntu/hadoop-data/dfsdata/datanode

# Copy setup files
cp core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
cp hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml

# Update ENV file to point to JAVA
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

# Formate namenot
cd /home/ubuntu/hadoop-data/dfsdata/namenode
hdfs namenode -format


# Start
start-dfs.sh
start-yarn.sh
