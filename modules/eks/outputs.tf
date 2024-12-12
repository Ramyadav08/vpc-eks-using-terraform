# Output the EKS cluster name
output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.example.name
}

# Output the EKS cluster ARN
output "eks_cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = aws_eks_cluster.example.arn
}

# Output the EKS cluster endpoint
output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.example.endpoint
}

# Output the EKS cluster certificate authority data
output "eks_cluster_certificate_authority_data" {
  description = "The EKS cluster certificate authority data"
  value       = aws_eks_cluster.example.certificate_authority[0].data
}

# Output the EKS cluster security group IDs
output "eks_cluster_security_group_ids" {
  description = "The security group IDs associated with the EKS cluster"
  value       = aws_eks_cluster.example.vpc_config[0].security_group_ids
}

# Output the EKS node group name
output "eks_node_group_name" {
  description = "The name of the EKS node group"
  value       = aws_eks_node_group.example1.node_group_name
}

# Output the EKS node instance role ARN
output "eks_node_group_instance_role_arn" {
  description = "The IAM role ARN associated with the EKS node group"
  value       = aws_eks_node_group.example1.node_role_arn
}
