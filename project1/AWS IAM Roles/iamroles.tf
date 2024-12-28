#Roles to access the AWS S3 Bucket
resource "aws_iam_role" "s3-levelupbucket-role" {
  name               = "s3-levelupbucket-role"
  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
})
}

#Policy to attach the S3 Bucket Role
resource "aws_iam_role_policy" "s3-levelupmybucket-role-policy" {
  name = "s3-levelupmybucket-role-policy"
  role = aws_iam_role.s3-levelupbucket-role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:*"
            ],
            "Resource": [
              "arn:aws:s3:::levelup-bucket-210",
              "arn:aws:s3:::levelup-bucket-210/*"
            ]
        }
    ]
})
}

#Instance identifier
resource "aws_iam_instance_profile" "s3-levelupbucket-role-instanceprofile" {
  name = "s3-levelupbucket-role"
  role = aws_iam_role.s3-levelupbucket-role.name
}