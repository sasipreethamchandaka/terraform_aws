terraform {
    backend "s3" {
        bucket = "remote-statefile-s3bucket"
        key = "terraform.tfsate"
        region = "us-east-1"
      
    }
  
}