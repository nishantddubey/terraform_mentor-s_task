variable "access_key" {
  description = "Your IAM access key"
}
variable "secret_key" {
  description = "Your IAM secret key"

}

variable "region" {
  description = "region"
  default = "ap-south-1"
}


variable "bucket_name" {
  type        = string
  description = "Name of the bucket."
  default = "website-hosting-default-bucket"
}


variable "main_file_name" {
  description = "Your index file name which you want to display"
  default     = "index.html"
}

variable "web_folder_path" {
  description = "Path of you folder which contain your web files and folders"
  default = "/home/sigmoid/Terraform_tutorial/mentor_task/sample_website"
}

