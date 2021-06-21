# SSH connection with Session Manager

Access AWS resources with Session Manager.

## Create AWS Resources by Terraform

```sh
docker-compose run terraform plan

docker-compose run terraform apply
```

## Settings

### Install AWS CLI

```sh
curl "https://d1vvhvl2y92vvt.cloudfront.net/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```

Confirming the installation.

```sh
which aws
aws --version
```

ref: [Installing the AWS CLI version 2 on MacOS - AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html)

### Configure

Configure iam user created by Terraform.  
Access Key and Secret Access Key will be written to the terraform state file (`terraform.tfstate`), please protect your backend state file judiciously.

ref: https://www.terraform.io/docs/providers/aws/r/iam_access_key.html

```sh
aws configure
```

ref: [Configuring the AWS CLI - AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)


### Install Session Manager Plugin

```sh
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/mac/sessionmanager-bundle.zip" -o "sessionmanager-bundle.zip"
unzip sessionmanager-bundle.zip
sudo ./sessionmanager-bundle/install -i /usr/local/sessionmanagerplugin -b /usr/local/bin/session-manager-plugin
```
ref: [(Optional) Install the Session Manager Plugin for the AWS CLI - AWS Systems Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html#install-plugin-macos)

## Starting a Session (AWS CLI)

```sh
aws ssm start-session --target instance-id
```

ref: [Start a Session - AWS Systems Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-sessions-start.html)

## Capistrano
Deploy Rails application by capistrano through Session Manager.  
Add proxy command settings below.

```
require 'net/ssh/proxy/command'
set :ssh_options,
    keys: %w[YOURE_SSH_KEY],
    forward_agent: true,
    auth_methods: %w[publickey],
    proxy: Net::SSH::Proxy::Command::new("aws ssm start-session --target #{ENV['INSTANCE_ID']} --document-name AWS-StartSSHSession --parameters 'portNumber=22'")
 ```
 
 ref: [Authentication & Authorisation - Capistrano](https://capistranorb.com/documentation/getting-started/authentication-and-authorisation/)
