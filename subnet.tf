resource "aws_route_table_association" "Public" {
  subnet_id      = aws_subnet.Public.id
  route_table_id = aws_route_table.IG.id
}
resource "aws_route_table_association" "Private" {
  subnet_id      = aws_subnet.Private.id
  route_table_id = aws_route_table.nat_route.id
}
resource "aws_route_table_association" "Data" {
  subnet_id      = aws_subnet.Data.id
  route_table_id = aws_route_table.nat_route_table.
}