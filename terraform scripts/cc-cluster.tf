terraform {
    required_providers {
        huaweicloud = {
            source  = "huaweicloud/huaweicloud"
            version = ">= 1.36.0"
        }
    }
}
 
provider "huaweicloud" {
    region     = "ap-southeast-3"
    access_key = var.access_key
    secret_key = var.secret_key
 
}
 

 
resource "huaweicloud_cce_cluster" "app_cluster" {
    name                   = "app-cluster"
    region                 = "ap-southeast-3"
    flavor_id              = "cce.s1.small"
    vpc_id                 = huaweicloud_vpc.realworld_vpc.id
    subnet_id              = huaweicloud_vpc_subnet.subnet_app.id
    container_network_type = "overlay_l2"
    }  


data "huaweicloud_availability_zones" "realworld_az" {} 

resource "huaweicloud_cce_node" "app_node" {
   name                  = "realworld-vm"
   flavor_id             = "c6.xlarge.4"
   os                    = "CentOS 7.6"
   cluster_id            = huaweicloud_cce_cluster.app_cluster.id
   availability_zone     = data.huaweicloud_availability_zones.realworld_az.names[0]
   password              = var.password
   charging_mode         = "prePaid"
   period_unit           = "month"
   period                = 1


   root_volume {
      size       = 50
      volumetype = "SSD"
   }
   data_volumes {
    size        = 100
    volumetype  = "SSD"
   }
}
  


