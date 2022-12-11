variable "bucketname-upload" {
  description = "Name of the destination bucket for photo uploads - Production env"
  type        = string
  default     = "nfish-des-kutter-upload"
}

variable "bucketname-store" {
  description = "Name of the bucket where the photos are stored after upload - Production env"
  type        = string
  default     = "nfish-des-kutter-store"
}

variable "bucketname-source-code" {
  description = "Name of the lambda source code - Production env"
  type        = string
  default     = "nfish-des-kutter-source-code"
}