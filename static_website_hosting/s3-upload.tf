resource "aws_s3_bucket_object" "sample_website_files" {

  depends_on = [aws_s3_bucket.bucket-1,aws_s3_bucket_acl.bucket-acl]

  for_each = fileset(var.web_folder_path, "**/*")

  bucket       = aws_s3_bucket.bucket-1.bucket      # Replace with your bucket name
  key          = each.value                           # Use the relative path of the file as the key
  source = "${var.web_folder_path}/${each.value}"
  acl          = "public-read"                        # Set the ACL to public-read to make the object publicly accessible
  content_type = "html"
}


#Output url to access the website
output "index_html_url" {
  value = "http://${aws_s3_bucket.bucket-1.bucket_regional_domain_name}/${var.main_file_name}"

}
