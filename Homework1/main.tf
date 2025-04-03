provider "aws" {
  region = "us-east-1" # или твой регион
}
resource "aws_iam_user" "blackpink" {
  for_each = toset(["jenny", "rose", "lisa", "jisoo"])
  name     = each.key
}
resource "aws_iam_user" "twice" {
  for_each = toset(["jihyo", "sana", "momo", "dahyun"])
  name     = each.key
}
resource "aws_iam_group" "blackpink" {
  name = "blackpink"
}
resource "aws_iam_group" "twice" {
  name = "twice"
}
resource "aws_iam_group_membership" "blackpink_members" {
  name = "blackpink-membership"
  users = [for user in aws_iam_user.blackpink : user.name]
  group = aws_iam_group.blackpink.name
}
resource "aws_iam_group_membership" "twice_members" {
  name = "twice-membership"
  users = [for user in aws_iam_user.twice : user.name]
  group = aws_iam_group.twice.name
}
# импорт существующих пользователей
# terraform import aws_iam_user.miyeon miyeon
# terraform import aws_iam_user.mina mina
resource "aws_iam_user" "miyeon" {
  name = "miyeon"
}
resource "aws_iam_user" "mina" {
  name = "mina"
}
resource "aws_iam_group_membership" "miyeon_blackpink" {
  name  = "miyeon-blackpink"
  users = [aws_iam_user.miyeon.name]
  group = aws_iam_group.blackpink.name
}
resource "aws_iam_group_membership" "mina_twice" {
  name  = "mina-twice"
  users = [aws_iam_user.mina.name]
  group = aws_iam_group.twice.name
}