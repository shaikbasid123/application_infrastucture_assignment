resource "aws_eks_cluster" "main" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_role.arn  # Assume role is created
  vpc_config {
    subnet_ids = var.private_subnets
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "eks-node-group"
  subnet_ids      = var.private_subnets
  # Add more configurations as needed
}
