module "sqldb" {
  source                          = "./modules/azmssql"

# SQL Server and Database scaling options
  server_id                       = module.sqlserver.id
  name                            = "demomssqldb"
  sku_name                        = "GP_S_Gen5_2"
  auto_pause_delay_in_minutes     = -1
  min_capacity                    = 1

# Tags for Azure Resources
  tags                            = var.tags


}