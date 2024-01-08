variable "rgname" {
    description = "Creating workspace and choosing variables as per the workspace"
    type = map(string)
    default = {
      "dev" = "dev-rg"
      "stage" = "stage-rg"
      "prod" = "prod-rg"
    }
  
}

module "rg" {
    source = "./module/rg-module" 
    rg-name = lookup(var.rgname, terraform.workspace , "default-rg")
    rg-location = var.rglocation
} 

/*module "vnet" {
   source = "./module/vnet-module"
   rg-name = var.rgname
   vnet-name = var.vnet-name
   vnet-ip = var.vnet-ip
   vnet-location = var.rglocation
}

module "subnet" {
  source = "./module/subnet-module"
  subnet-name = var.sub-name
  rg-name = var.rgname
  vnet-name = var.vnet-name
  sub-ip = var.sub-ip
}*/

