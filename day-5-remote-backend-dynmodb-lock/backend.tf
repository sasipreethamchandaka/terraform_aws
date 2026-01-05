terraform {
    backend "s3" {
        bucket = "remote-backend-dynamodb"
        key = "terraform.tfsate"
        region = "us-east-1"
        #use_lockfile = true
        dynamodb_table = "dynmodb-backend-remotelock"
    }
  
}