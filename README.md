# msit-terraform-infra
# Terraform
#What is Terraform
 HashiCorp Terraform is an infrastructure as code tool that lets you define both cloud and on-prem resources in human-readable configuration files that you can version,   reuse, and share.

#How does terraform works?
 Terraform creates and manages resources on cloud platforms and other services through their application programming interfaces (APIs). Providers enable Terraform to   work with virtually any platform or service with an accessible API.

 ![image](https://user-images.githubusercontent.com/90096333/179201143-4cbcc9b7-0a2d-4371-8a02-b06a2aad71fc.png)

  Terraform creates and manages cloud platforms and services through their APIs
  Terraform workflow consists of three stages:
  ![image](https://user-images.githubusercontent.com/90096333/179211668-773c72e5-f046-4a02-a80f-48a2e02e3813.png)

 #Installation of Terraform on windows
 check the below link for the installtion of terraform
 https://spacelift.io/blog/how-to-install-terraform
 
  #Main Commands of terraform 
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure
 
 In the about scripts iam using Aws cloud provider
 firstly create an Iam user in aws >> give the user the * Programmatic access *Console Access >> attach the administator Access 
 Then Download the Excel file contains the Username , Password,Access Key,Secret Key and console link 
 
 Create a Vpc and subnet.
 Create a application installations.
 Create a sample Lambda function.
 Create a Elastic kubernetes cluster.
 
 Below are some refference links
 https://www.ashnik.com/install-jenkins-on-aws-ec2-instance-using-terraform/
 https://medium.com/@haissamhammoudfawaz/create-a-aws-lambda-function-using-terraform-and-python-4e0c2816753a
 https://www.sensedia.com/post/how-create-cluster-kubernetes-terraform-aws-eks
