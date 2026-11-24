locals {
  user_data = templatefile("${path.module}/userdata.sh.tftpl", {
    default_user = var.default_user
    nginx_tag    = var.nginx_tag
  })
}

resource "aws_key_pair" "lab" {
  key_name   = "${var.name_prefix}-key"
  public_key = var.ssh_public_key

  tags = {
    Name = "${var.name_prefix}-key"
  }
}

resource "aws_instance" "web" {
  for_each = var.protect_instances ? {} : var.instances

  ami                         = var.ami_id
  instance_type               = each.value.instance_type
  subnet_id                   = var.subnet_ids[each.value.subnet_key]
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = aws_key_pair.lab.key_name
  associate_public_ip_address = var.associate_public_ip
  ebs_optimized               = true
  monitoring                  = var.detailed_monitoring
  user_data                   = local.user_data
  user_data_replace_on_change = var.user_data_replace_on_change

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  root_block_device {
    encrypted             = true
    volume_type           = "gp3"
    volume_size           = var.root_volume_gb
    delete_on_termination = true

    tags = merge(var.common_tags, {
      Name = "${var.name_prefix}-${each.key}-root"
    })
  }

  tags = merge(var.extra_tags, {
    Name = "${var.name_prefix}-${each.key}"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}

resource "aws_instance" "protected" {
  for_each = var.protect_instances ? var.instances : {}

  ami                         = var.ami_id
  instance_type               = each.value.instance_type
  subnet_id                   = var.subnet_ids[each.value.subnet_key]
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = aws_key_pair.lab.key_name
  associate_public_ip_address = var.associate_public_ip
  ebs_optimized               = true
  monitoring                  = var.detailed_monitoring
  user_data                   = local.user_data
  user_data_replace_on_change = var.user_data_replace_on_change

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  root_block_device {
    encrypted             = true
    volume_type           = "gp3"
    volume_size           = var.root_volume_gb
    delete_on_termination = true

    tags = merge(var.common_tags, {
      Name = "${var.name_prefix}-${each.key}-root"
    })
  }

  tags = merge(var.extra_tags, {
    Name = "${var.name_prefix}-${each.key}"
  })

  lifecycle {
    ignore_changes  = [ami]
    prevent_destroy = true
  }
}
