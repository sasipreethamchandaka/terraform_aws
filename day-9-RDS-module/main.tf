module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "demodb"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "database_rds"
  username = "user"
  port     = "3306"

  #iam_database_authentication_enabled = true
   manage_master_user_password = true

  vpc_security_group_ids = ["sg-03ac0530c99a36aac"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  
  tags = {
    Owner       = "user"
    Environment = "sasi"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = ["subnet-0b61ff6c668ce6b65", "subnet-05720358e261eb02f"]

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = true

  
  
}