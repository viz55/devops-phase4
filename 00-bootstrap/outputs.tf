output "bucket_name" {
  description = "Name of the state bucket"
  value       = aws_s3_bucket.state.bucket
}

output "table_name" {
  description = "Name of the lock table"
  value       = aws_dynamodb_table.locks.name
}
