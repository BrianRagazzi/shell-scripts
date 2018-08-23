#!/usr/bin/env bash

sudo true
sudo apt-get update
sudo apt-get install git openjdk-8-jre-headless screen -y

curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

git config --global --unset core.autocrlf
java -jar BuildTools.jar

curl -o BungeeCord.jar https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar

mkdir ./servers
mkdir ./servers/survive
cp ./spigot*.jar ./servers/survive/spigot.jar

cd ./servers/survive
cat > start.sh <<'EOF'
#!/bin/sh
java -Xms512M -Xmx1G -XX:MaxPermSize=128M -XX:+UseConcMarkSweepGC \
  -jar spigot.jar
EOF

sudo echo “eula=true” > ./servers/survive/eula.txt

sudo chmod +x start.sh

screen -S "survive" -U -m sh start.sh
# sudo ./start.sh
