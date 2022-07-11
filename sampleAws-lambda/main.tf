provider "aws" {
  access_key = "Give a Acces key here from iam user credentials"
  secret_key = "Give a secret key here from iam user credentials"
  region     = "ap-south-1"
}
# Creation of Iam Role for lambda
resource "aws_iam_role" "lambda_role" {
name   = "terraform_aws_Lambda_Role"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
# Creation of IAM policy for lambda
resource "aws_iam_policy" "iam_policy_for_lambda" {
 
 name         = "aws_iam_policy_for_terraform_aws_lambda_role"
 path         = "/"
 description  = "AWS IAM Policy for managing aws lambda role"
 policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}
 # Policy attachement on role

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}
 # Generate An archive from content , a file or a directory of files
data "archive_file" "zip_the_python_code" {
type        = "zip"
source_dir  = "${path.module}/python/"
output_path = "${path.module}/python/hello-python.zip"
}

# Create a Lambda function
# In terraform ${path.module} is current directory.
resource "aws_lambda_function" "terraform_lambda_func" {
filename                       = "${path.module}/python/hello-python.zip"
function_name                  = "Aws_Lambda_Function"
role                           = aws_iam_role.lambda_role.arn
handler                        = "hello-python.lambda_handler"
runtime                        = "python3.8"
depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

output "terraform_aws_role_output" {
    value = aws_iam_role.lambda_role.name
}

output "terraform_aws_role_arn_output"{
    value = aws_iam_role.lambda_role.arn
}

output "terraform_logging_arn_output"{
    value = aws_iam_policy.iam_policy_for_lambda.arn
}