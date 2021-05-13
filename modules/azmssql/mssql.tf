#--------------------------------------------------------------------
# SQL Database creation - Default edition:"Standard" and objective:"S1"
#--------------------------------------------------------------------
resource "azurerm_mssql_database" "database" {
  name                        = var.name
  server_id                   = var.server_id
  max_size_gb                 = var.max_size_gb
  auto_pause_delay_in_minutes = var.auto_pause_delay_in_minutes
  min_capacity                = var.min_capacity
  sku_name                    = var.sku_name
  elastic_pool_id             = var.elastic_pool_id
  collation                   = var.collation
  create_mode                 = var.create_mode
  license_type                = var.license_type
  read_replica_count          = var.read_replica_count
  read_scale                  = var.read_scale
  restore_point_in_time       = var.restore_point_in_time
  sample_name                 = var.sample_name
  zone_redundant              = var.zone_redundant
  tags                        = var.tags

}