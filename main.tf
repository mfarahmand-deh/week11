resource "aws_security_group" "web-sg" {
  name        = "staging-web-sg"
  description = "Staging web server security group"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["203.0.113.10/32"]  # only your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]      # internal VPC only
  }
}
