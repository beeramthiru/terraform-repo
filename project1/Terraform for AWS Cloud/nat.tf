#Define External IP 
resource "aws_eip" "custom_nat" {
  domain   = "vpc"
}
resource "aws_nat_gateway" "custom-nat-gw" {
  allocation_id = aws_eip.custom_nat.id
  subnet_id     = aws_subnet.public_subnet_1.id
  depends_on    = [aws_internet_gateway.custom_gw]
}
resource "aws_route_table" "custom_route_private" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.custom-nat-gw.id
  }
  tags = {
    Name = "custom_route_private"
  }
}
# route associations private
resource "aws_route_table_association" "custom-private-1-a" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.custom_route_private.id
}
resource "aws_route_table_association" "custom-private-1-b" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.custom_route_private.id
}
resource "aws_route_table_association" "custom-private-1-c" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.custom_route_private.id
}