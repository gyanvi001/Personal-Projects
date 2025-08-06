resource "aws_security_group" "WanderLust_Jenkins_SG" {
  name        = "WanderLust_SG"
  description = "Allow necessary inbound access"
  vpc_id      = aws_default_vpc.default.id

  // SSH
  ingress {
    description = "Allow port 22 for SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // HTTP
  ingress {
    description = "Allow port 80 for HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // HTTPS
  ingress {
    description = "Allow port 443 for HTTPS access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Custom TCP 6379 (likely Redis)
  ingress {
    description = "Allow port 6379 for Redis"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Custom TCP range 3000–10000
  ingress {
    description = "Allow ports 3000–10000 (Node apps, dashboards, etc.)"
    from_port   = 3000
    to_port     = 10000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Custom TCP range 30000–32767 (Kubernetes NodePort)
  ingress {
    description = "Allow ports 30000–32767 (K8s NodePort)"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Custom TCP port 6443 (K8s API Server)
  ingress {
    description = "Allow port 6443 (K8s API Server)"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // SMTP
  ingress {
    description = "Allow port 25 for SMTP"
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // SMTPS
  ingress {
    description = "Allow port 465 for SMTPS"
    from_port   = 465
    to_port     = 465
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

