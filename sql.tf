module "sqlserver" {
  source                          = "./modules/azsqlserver"

# Resource Group, locations
  resource_group_name             = local.resource_group_name
  location                        = local.location


# SQL Server  scaling options
  sqlserver_name                  = "sqldbserver-db01"
  administrator_login             = "sqladmin"
  administrator_login_password    = "cvSoGoebgpzP2MImo8Uv" 

# SQL Server  Audit policies  
  enable_auditing_policy          = true
  log_retention_days              = 30
  auditstorageaccname             = "sqldevacctest"
  virtual_network_subnet_ids      = [module.vnet.subnet_ids[0]]

# AD administrator for an Azure SQL server
  enable_sql_ad_admin             = false
  ad_admin_login_name             = ""

# Tags for Azure Resources
  tags                            = var.tags

}