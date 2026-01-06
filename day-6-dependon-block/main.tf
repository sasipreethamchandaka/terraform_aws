resource "aws_instance" "name" {
    ami = "ami-068c0051b15cdb816"
    instance_type = "t2.micro"
  
}
resource "aws_s3_bucket" "name" {
    bucket = "aakhandas3bucket"
    depends_on = [ aws_instance.name ]
  
}