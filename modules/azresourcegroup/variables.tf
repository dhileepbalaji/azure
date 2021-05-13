variable "name" {}
variable "location" {
    type = string
    default = "Central US"    
}
variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    environment = "dev"
  }
}