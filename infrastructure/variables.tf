variable "bucketname-upload" {
  description = "Name of the destination bucket for photo uploads - Production env"
  type        = string
  default     = "nfish-des-kutter-upload1"
}

variable "bucketname-store" {
  description = "Name of the bucket where the photos are stored after upload - Production env"
  type        = string
  default     = "nfish-des-kutter-store1"
}

variable "NEWS_API_KEY" {
  description = "NEWS_API_KEY"
  type        = string
  sensitive   = true
}
