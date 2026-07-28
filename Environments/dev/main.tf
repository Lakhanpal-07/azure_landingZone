module "resource_group" {
  source = "../../modules/az_rg_group"
  rgs    = var.rgs

}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../modules/az_vnets"
  vnets      = var.vnets

}

module "subnets" {
  depends_on = [module.virtual_network]
  source     = "../../modules/az_subnets"
  subnets    = var.subnets
}

module "Bastion_host" {
  depends_on = [module.subnets, module.public_ip]
  source     = "../../modules/az_Bastion"
  Bastion    = var.Bastion

}

module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../modules/az_pip"
  pip        = var.pip
}

module "nat_gateway" {
  depends_on              = [module.subnets, module.public_ip]
  source                  = "../../modules/AZ_NAT"
  nat                     = var.nat
  nat_subnet_associations = var.nat_subnet_associations
}

module "network_interface_card" {
  depends_on = [module.subnets, module.public_ip]
  source     = "../../modules/az_NIC"
  nic        = var.nic
}

module "network_security_group" {
  depends_on = [module.subnets , module.resource_group , module.virtual_network]
  source = "../../modules/az_NSG"
  nsg = var.nsg_map
}

module "linux_virtual_machine" {
  depends_on = [module.subnets, module.network_interface_card]
  source     = "../../modules/az_VM"
  vm_linux   = var.vm_linux
}
