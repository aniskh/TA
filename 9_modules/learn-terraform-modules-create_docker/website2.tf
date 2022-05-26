module "mywebserver2" {
  source         = "./modules/mydockerwebserver"
  container_name = "website2"
}