resource "aws_key_pair" "lab" {
  key_name   = "${local.name_prefix}-key"
  public_key = var.ssh_public_key

  tags = {
    Name       = "${local.name_prefix}-key"
    CostCenter = "lab1"
  }
}

resource "aws_instance" "web" {

  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public["public-1"].id
  vpc_security_group_ids      = [aws_security_group.web.id]
  key_name                    = aws_key_pair.lab.key_name
  associate_public_ip_address = false
  ebs_optimized               = true
  monitoring                  = true

  user_data = templatefile("${path.module}/userdata.sh.tftpl", {
    default_user = var.default_user
    nginx_tag    = var.nginx_tag
  })
  user_data_replace_on_change = true

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  root_block_device {
    encrypted             = true
    volume_type           = "gp3"
    volume_size           = 12
    delete_on_termination = true

    tags = merge(local.common_tags, {
      Name = "${local.name_prefix}-web-root"
    })
  }

  tags = {
    Name = "${local.name_prefix}-web"
  }

  lifecycle {
    ignore_changes = [ami]
  }
}
