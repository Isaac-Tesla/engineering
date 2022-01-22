resource "azurerm_hdinsight_kafka_cluster" "kafka_cluster" {
  name                = "kafkacluster"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  cluster_version     = "4.0"
  tier                = "Standard"

  component_version {
    kafka = "2.1"
  }

  gateway {
    enabled  = true
    username = "acctestusrgw"
    password = "TerrAform123!"
  }

  storage_account {
    storage_container_id = azurerm_storage_container.big_data.id
    storage_account_key  = azurerm_storage_account.big_data.primary_access_key
    is_default           = true
  }

  roles {
    head_node {
      vm_size  = "Standard_D3_V2"
      username = "acctestusrvm"
      password = "AccTestvdSC4daf986!"
    }

    worker_node {
      vm_size                  = "Standard_D3_V2"
      username                 = "acctestusrvm"
      password                 = "AccTestvdSC4daf986!"
      number_of_disks_per_node = 3
      target_instance_count    = 3
    }

    zookeeper_node {
      vm_size  = "Standard_D3_V2"
      username = "acctestusrvm"
      password = "AccTestvdSC4daf986!"
    }
  }
}