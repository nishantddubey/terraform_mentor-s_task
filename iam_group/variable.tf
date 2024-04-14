variable "modify_groups_count" {
  description = "Number of group you want to create which can modify s3"
  default = 1
}

variable "view_groups_count" {
description = "Number of group you want to create which can only View s3"
  default = 1
  
}

variable "access_key" {
  description = "Your AWS Access key"
}


variable "secret_key" {
  description = "Your AWS Secret Access key"
}