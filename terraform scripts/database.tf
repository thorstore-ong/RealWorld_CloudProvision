
resource "huaweicloud_rds_instance" "realworld_db" {
  name              = "mysql-db"
  flavor            = "rds.mysql.n1.xlarge.2"
  vpc_id            = huaweicloud_vpc.realworld_vpc.id
  subnet_id         = huaweicloud_vpc_subnet.subnet_db.id
  security_group_id = var.security_group_id
  availability_zone = [data.huaweicloud_availability_zones.realworld_az.names[0]]
  charging_mode     = "prePaid"
  period_unit       = "month"
  period            = 1

  db{
    type = "MySQL"
    version = 8.0
    password = var.password
  }

  volume {
    type = "CLOUDSSD"
    size = 500
  }
}

