variable "bucketname" {
  default     = "my-konradassign-bucket"
  description = "the name of the S3 bucket"
  type        = string
}

variable "region" {
  default     = "us-east-1"
  description = "the name of the region"
  type        = string
}

variable "account_id" {
  default     = 211125698138
  type        = number
  description = "your aws account id"

}

variable "domain_name" {
  default     = "temmytope.com.ng"
  description = "the name of the region"
  type        = string
}