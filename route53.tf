# Create DNS records pointing to Load Balancer
resource "aws_route53_record" "artifactory" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.subdomain
  type    = "A"


  alias {
    name                   = data.kubernetes_service.ingress_nginx.status[0].load_balancer[0].ingress[0].hostname
    zone_id                = data.aws_lb_hosted_zone_id.main.id # Gets the canonical hosted zone ID for ELB
    evaluate_target_health = true
  }

  depends_on = [
    helm_release.ingress_nginx_controller,
  ]
}
