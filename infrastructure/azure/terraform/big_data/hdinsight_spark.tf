resource "azurerm_hdinsight_spark_cluster" "spark_cluster" {
  name                = "sparkcluster"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  cluster_version     = "3.6"
  tier                = "Standard"

  component_version {
    spark = "3.2"
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
      vm_size  = "Standard_A3"
      username = "acctestusrvm"
      password = "AccTestvdSC4daf986!"
    }

    worker_node {
      vm_size               = "Standard_A3"
      username              = "acctestusrvm"
      password              = "AccTestvdSC4daf986!"
      target_instance_count = 3
    }

    zookeeper_node {
      vm_size  = "Medium"
      username = "acctestusrvm"
      password = "AccTestvdSC4daf986!"
    }
  }
}