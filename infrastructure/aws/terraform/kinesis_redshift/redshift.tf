resource "aws_redshift_cluster" "test_cluster" {
  cluster_identifier = "tf-redshift-cluster"
  database_name      = "test"
  master_username    = "testuser"
  master_password    = "T3stPass"
  node_type          = "dc2.large"
  cluster_type       = "single-node"
  skip_final_snapshot = true
}