#!/bin/bash
# TO REUSE THIS CODE IN A VIDEO, YOU MUST DM foxytoux ON DISCORD OR SEND AN EMAIL TO foxytoux@gmail.com

# Confirmation prompt
read -p "Do you want to download and set up the Minecraft server? (type 'YES' to proceed): " confirm_download

if [ "$confirm_download" != "YES" ]; then
    echo "Aborted. No files were downloaded or modified."
    exit 0
fi

# Install OpenJDK 21
echo "Installing OpenJDK 21..."
sudo apt update
sudo apt install -y openjdk-21-jdk

# Set environment variables
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Display Java version
java -version

# Ask the user for the server.jar link
read -p "Enter the link to the server.jar (type 'none' or leave blank for default 1.21.4): " server_jar_link

# Download server JAR
if [ -z "$server_jar_link" ] || [ "$server_jar_link" == "none" ]; then
    server_jar_link="https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar"
fi
wget "$server_jar_link" -O server.jar

# Ask the user if they accept the EULA
read -p "Do you accept the Minecraft EULA? (type 'yes' to accept): " accept_eula

if [ "$accept_eula" != "yes" ]; then
    echo "You must accept the EULA to run the Minecraft server. Exiting."
    exit 1
fi

# Modify eula.txt to true
echo "eula=true" > eula.txt

# Modify server.properties to set online-mode to false
echo "online-mode=false" >> server.properties

# Launch your server here
echo "Launching server..."
java -Xmx2G -Xms1G -jar server.jar nogui

# End of server startup command
