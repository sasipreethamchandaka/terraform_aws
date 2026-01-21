############ example-1 s3 bucket creation condition based ####################




variable "create_bucket" {
   description = "Set to true to create the S3 bucket."
   type        = bool
   default     = true         #true = 1  bucket created , false = 0;
 }

 resource "aws_s3_bucket" "demo" {
   count = var.create_bucket ? 1 : 0
   bucket= "aqws-wed-fgbnm,"
  
   tags = {
     Name  = "ConditionalBucket"
     Environment = "Dev"
   }
}


############ example-2 s3 bucket creation condition based within available regions ####################

 variable "aws_region" {
   description = "The region in which to create the infrastructure"
   type        = string
   default     = "us-west-2" # here we need to define either us-west-1 or eu-west-2 if i give other region will get error 
   validation {
     condition = var.aws_region == "us-west-1" || var.aws_region == "us-west-2"
     error_message = "The variable 'aws_region' must be one of the following regions: us-west-2, us-west-1"
   }
 }


  resource "aws_s3_bucket" "dev" {
     bucket = "gfih-siurh-giushgids"
     force_destroy = true
    
  
 }

#after run this will get error like The variable 'aws_region' must be one of the following regions: us-west-2,│ eu-west-1, so it will allow any one region defined above in conditional block

################## example-3 with numeric condition in thid condition if ec2 instance = t2.micro only instance will create(count = var.instance_type == "t2.micro" ? 1 : 0) but i am passing t2.nano so ec2 will not create #######################

variable "ami" {
  type    = string
  default = "ami-07ff62358b87c7116"
}

variable "instance_type" {
  type = string
  default = "t2.nano"
}


resource "aws_instance" "dev" {
  ami           = var.ami
  instance_type = var.instance_type
  count         = var.instance_type == "t2.micro" ? 1 : 0
  tags = {
    Name = "dev_server"
  }
}

# No changes. Your infrastructure matches the configuration.

# Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.


# ## Example-4 ## you can try 

variable "environment" {
  default = ["dev","QA", "Prod"]
}

resource "aws_instance" "server" {
  count         = var.environment == "Prod" ? 3 : 1
  ami           = "ami-07ff62358b87c7116"
  instance_type = "t2.micro"

  tags = {
    Name = "server-${count.index}"
  }
}

# In this case:
# If var.environment == "prod" → count = 3
# Else (like dev, qa, etc.) → count = 1
# terraform apply -var="environment=dev"
