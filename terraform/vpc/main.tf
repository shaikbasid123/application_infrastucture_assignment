resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = "us-west-2a"  # Adjust as needed
  map_public_ip_on_launch = false
}

resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 2}.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_instance" "windows_ec2" {
  ami           = "ami-0c55b159cbfafe1f0" 
  instance_type = "t3.medium"
  subnet_id     = var.public_subnets[0]
  security_groups = [aws_security_group.ec2_sg.id] 

  
  user_data = <<-EOF
              <powershell>
              Install-WindowsFeature Web-Server  # For hosting Apps 4-5
              # Add Oracle installation script here, e.g.:
              # Download and install Oracle Database
              Invoke-WebRequest -Uri 'https://your-oracle-installer-url' -OutFile 'oracle-setup.exe'
              Start-Process -FilePath 'oracle-setup.exe' -ArgumentList '/silent' -Wait  # Use silent install options
              </powershell>
              EOF
}
