# Reads the information from the remote statefile
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "b55-terraform-state"
    key    = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

# fetches the information of the secret
data "aws_secretsmanager_secret" "secrets" {
  name = "robot/secrets"
}


# Fetches the secrets version from the above server
data "aws_secretsmanager_secret_version" "secret_version" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}


output "example" {
  value = jsondecode(data.aws_secretsmanager_secret_version.secret_version.secret_string)["DOCDB_USERNAME"]
}