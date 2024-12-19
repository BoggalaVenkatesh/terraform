resource "aws_route53_record" "expense" {
  count   = length(var.instance_names)
  zone_id = local.zone_id
  #backend.venkatesulu.online
  name            = var.instance_names[count.index] == "frontend" ? var.domain_name : "${local.instance_names[count.index]}.${local.domain_name}" #Interpolation ${ ... } 
  type            = "A"
  ttl             = 1
  records         = var.instance_names[count.index] == "frontend" ? [aws_instance.terraform[count.index].public_ip] : [aws_instance.terraform[count.index].private_ip]
  allow_overwrite = true # if already existing ID is there it will overwrite 
}