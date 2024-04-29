# Description
You will want this if you want to have your Lightsail give you a secure Jenkins instance on your domain name out of the box.

# Getting Started

This assumes that you have inserted the script from the `jenkins-in-lightsail.sh`, `nginx-in-lightsail.sh` shell scripts as an immediate script to run, or are starting from an AWS Lightsail instance immediately after creation.

## Setting up Domain
You should first set up your jenkins.domain.com, www.domain.com, domain.com DNS settings (where `domain.com` is your domain). Change IP Value for your static ip.
```
Type	    Host        IP Value            TTL
------      ------      ----------          -----
A Record	@           x.x.x.xx.xxxx       Automatic
A Record	jenkins     x.x.x.xx.xxxx       Automatic
A Record	www         x.x.x.xx.xxxx       Automatic
```

Then you must go to your Lightsail Dashboard > Networking and add ports for `8080` (custom app port for Jenkins), `80` (http), and `443` (https)


## Setting up Jenkins


Run (if immediately after creating the Lightsail instance)
```
sudo jenkins-in-lightsail.sh
```

## Setting up Nginx

Make sure to provide the domain name and the email you want to register the ssl to.
Run (if immediately after creating the Lightsail instance and the Jenkins)
```
sudo nginx-in-lightsail.sh example.com your-email@example.com
```

## Manual Check
1. Go to your domain name (whatever you chose as domain name): `https://example.com` and `https://www.example.com`. If you see the welcome heading then this is successful.
2. Go to the `jenkins.example.com` to see if you get the page asking for an admin token. If you do you are successfully deployed on Jenkins and are free to provide your secure token.