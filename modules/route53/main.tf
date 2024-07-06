resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "nginx" {
  zone_id = aws_route53_zone.main.zone_id
  name = var.subdomain_name
  type = "A"
  ttl = "3600"
  records = [var.nat_public_ip]
}