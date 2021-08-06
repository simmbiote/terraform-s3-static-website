# Terraform for Static S3 Website Hosting

A boilerplate for provisioning an S3 bucket for prototyping a static website.

## Requirements

### AWS profile

If not done already, an AWS profile needs to be configured on your device. You can do this via the AWS CLI (v2) - https://aws.amazon.com/cli/  
Run `aws configure`.
You will be prompted for your for your AWS Access Key and Secret Key.

### Control over Block Public Access

Your organisation may not allow you to enable public access to objects in an S3 bucket.
If this is the case, then you need to ask them to review this configuration, or use a different account that allows it.

### Terraform cli

You'll need the terraform cli to provision the infrastructure.  
See https://www.terraform.io/ for installation details.

## Overview

This terraform setup will provision:

- An S3 bucket.
- The bucket will be populated with the content of the /html/ folder.

## Provisioning AWS Infrastructure and Deploying

1. In the /terraform/ directory, copy vars.tfvars.sample to vars.tfvars and adapt the variables.
2. Use the /html/ folder for your static html site. This must include a /index.html and /error.html.
3. If you want to use the static website feature of S3, uncomment the resources described in main.tf.
4. In the /terraform/ folder, run `terraform init` the first time.
5. Run `terraform plan -var-file="vars.tfvars"` to do a dry run.
6. If satisfied, run `terraform apply -var-file="vars.tfvars"`.

Once complete you will be given the S3 Bucket Website URL in the command output.

When you want to deploy changes, repeat step 6.

Remember to delete your prototype when you no longer need it:  
Run `terraform destroy -var-file="vars.tfvars"` from the /terraform/ folder.
