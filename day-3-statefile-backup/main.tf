resource "aws_instance" "name" {
    ami = "ami-068c0051b15cdb816"
    instance_type = "t2.medium"
   tags = {
     Name = "sasi-chandaka"
   }

}
resource "aws_s3_bucket" "sasi123" {
  bucket = "sasi123-bucket"
}





resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.sasi123.id
  versioning_configuration {
    status = "Enabled"
  }
}