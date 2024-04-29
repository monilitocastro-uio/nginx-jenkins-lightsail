#!/bin/bash

sudo apt update
sudo apt install openjdk-11-jdk

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins.gpg > /dev/null

sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update

sudo apt install jenkins

sudo systemctl start jenkins

sudo systemctl status jenkins
 

echo "Jenkins is now installed and running. This will modify JENKINS_ARGS in /etc/default/jenkins to set the --prefix flag."

# Path to Jenkins configuration file
jenkins_config="/etc/default/jenkins"

# Check if the --prefix flag is already set
if grep -q -- "--prefix=/jenkins" "$jenkins_config"; then
    echo "The --prefix=/jenkins flag is already set in JENKINS_ARGS."
else
    # Using sed to append '--prefix=/jenkins' to the JENKINS_ARGS line
    sed -i '/JENKINS_ARGS="/ s/"$/ --prefix=\/jenkins"/' $jenkins_config
    echo "Added --prefix=/jenkins to JENKINS_ARGS in $jenkins_config."
fi

# Optional: Display the modified line for verification
grep "JENKINS_ARGS" $jenkins_config



sudo systemctl restart jenkins