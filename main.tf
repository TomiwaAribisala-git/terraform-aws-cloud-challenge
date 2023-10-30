/*
terraform {
  backend "s3" {
    bucket         = "terraform-cloud-challenge-state-bucket"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-north-1"
    #encrypt        = true
    #dynamodb_table = "terraform-cloud-challenge-state-lock"
  }
}
*/

module "terraform-web-app" {
  source = "./modules/terraform-web-app"
  alb-name = var.alb-name
  node-ls-port = var.node-ls-port
  node-tg-name = var.node-tg-name
  node-tg-port = var.node-tg-port
  subnet1_id = var.subnet1_id
  subnet2_id = var.subnet2_id
  avail_zone1 = var.avail_zone1
  avail_zone2 = var.avail_zone2
  private-subnet1-cidr-block = var.private-subnet1-cidr-block
  private-subnet2-cidr-block = var.private-subnet2-cidr-block
  private-subnet1-route-table-cidr-block = var.private-subnet1-route-table-cidr-block
  private-subnet2-route-table-cidr-block = var.private-subnet2-route-table-cidr-block
  asg-name = var.asg-name
  instance_type = var.instance_type
}