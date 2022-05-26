module "mywebserver" {
  source         = "./modules/mydockerwebserver"
  container_name = "website1"
}