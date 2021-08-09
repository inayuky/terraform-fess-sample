# SSMからAmazonLinux2の最新のAMIを取得
data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "fess" {
  ami = data.aws_ssm_parameter.amzn2_ami.value

  instance_type = "t2.medium"

  vpc_security_group_ids = [aws_security_group.this.id]

  subnet_id = aws_subnet.public.id

  # fessのインストール
  user_data = file("./install_fess.sh")
}

output "public_ip" {
  value = aws_instance.fess.public_ip
}
