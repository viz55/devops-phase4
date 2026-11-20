
resource "aws_security_group" "legacy" {
  name        = "devops-phase4-manual-sg"
  description = "Created by hand for the import demo"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "devops-phase4-manual-sg"
  }
}

moved {
  from = aws_security_group.manual
  to   = aws_security_group.legacy
}

import {
  to = aws_security_group.legacy
  id = "sg-0de103d040f15eda2"
}
