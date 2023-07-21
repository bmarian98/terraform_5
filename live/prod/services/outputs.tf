/* output "alb_dns_name" {
  value = module.alb.alb_dns_name
} */

output "s3_url" {
  value = module.s3_static_website.website_url
}
