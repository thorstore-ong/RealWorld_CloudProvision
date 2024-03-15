 
resource "huaweicloud_vpc" "realworld_vpc" {
    name = "realworld-vpc"
    cidr = "10.0.0.0/16"
}


resource "huaweicloud_vpc_subnet" "subnet_app" {
    name          = "subnet-app"
    cidr          = "10.0.1.0/24"
    gateway_ip    = "10.0.1.1"
    primary_dns   = "100.125.1.250"
    secondary_dns = "100.125.1.14"
    vpc_id        = huaweicloud_vpc.realworld_vpc.id
}

resource "huaweicloud_vpc_subnet" "subnet_db" {
    name          = "subnet-db"
    cidr          = "10.0.2.0/24"
    gateway_ip    = "10.0.2.1"
    primary_dns   = "100.125.1.250"
    secondary_dns = "100.125.1.14"
    vpc_id        = huaweicloud_vpc.realworld_vpc.id
}
 
 
resource "huaweicloud_vpc_bandwidth" "app_bandwith" {
    name = "app-bandwidth"
    size = 5
}
 
resource "huaweicloud_vpc_eip" "eip_app" {
    publicip {
        type  = "5_bgp"
    }
 
    bandwidth{
        share_type  = "WHOLE"
        id          = huaweicloud_vpc_bandwidth.app_bandwith.id
    }
}


resource "huaweicloud_nat_gateway" "nat_gateway" {
    name      = "nat-gateway"
    spec      = "1"
    vpc_id    = huaweicloud_vpc.realworld_vpc.id
    subnet_id = huaweicloud_vpc_subnet.subnet_app.id

}

# resource "huaweicloud_nat_dnat_rule" "test" {
#   nat_gateway_id        = huaweicloud_nat_gateway.nat_gateway.id
#   floating_ip_id        = huaweicloud_vpc_eip.eip_app.id
#   port_id               = huaweicloud_cce_node.app_node.id
#   protocol              = "tcp"
#   internal_service_port = 23
#   external_service_port = 823
# }

# resource "huaweicloud_nat_snat_rule" "test" {
#   nat_gateway_id = huaweicloud_nat_gateway.nat_gateway.id
#   floating_ip_id = huaweicloud_vpc_eip.eip_app.id
#   subnet_id      = huaweicloud_vpc_subnet.subnet_app.id
# }






