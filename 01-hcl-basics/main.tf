resource "aws_vpc" "main" {
  cidr_block = lookup(var.env_cidrs, var.environment, "10.50.0.0/16")

  tags = merge(local.common_tags, var.extra_tags, {
    Name = format("%s-vpc", local.name_prefix)
    Tier = local.is_prod ? "critical" : "standard"
  })
}

resource "aws_internet_gateway" "main" {
  count  = var.create_igw ? 1 : 0
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = format("%s-igw", local.name_prefix)
  })

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, each.value.cidr_index)
  availability_zone       = local.az_names[each.value.az_index]
  map_public_ip_on_launch = each.value.public

  tags = merge(local.common_tags, {
    Name = format("%s-%s", local.name_prefix, each.key)
  })
}

resource "aws_security_group" "web" {
  name_prefix = "${local.name_prefix}-web-"
  description = "Web security group v2"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      description = "Allow TCP ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = merge(local.common_tags, {
    Name = format("%s-web", local.name_prefix)
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "extra" {
  count = var.extra_sg_count

  name_prefix = "${local.name_prefix}-extra-${count.index}-"
  description = "Extra security group ${count.index}"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = format("%s-extra-%d", local.name_prefix, count.index)
  })
}

resource "terraform_data" "network_ready" {
  input = "network is ready"

  depends_on = [
    aws_subnet.this,
    aws_internet_gateway.main,
    aws_security_group.web,
  ]
}

resource "terraform_data" "count_demo" {
  count            = length(var.demo_names)
  triggers_replace = var.demo_names[count.index]
}

resource "terraform_data" "foreach_demo" {
  for_each         = toset(var.demo_names)
  triggers_replace = each.value
}
