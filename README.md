Dynamic Route53 Puppet Module adds the ability for an Amazon EC2 instance to add itself to Route53 DNS when it boots, as well as remove itself when it is shut down.

It's DNS name is defined by the 'Name' tag set on the instance.

It has the ability to both work with private DNS as well as public - simply by adjusting the `private_dns` parameter in the class.

When `private_dns` is specified it will add an A record with it's internal IP as the value, if it is not specified it will default to public DNS and will add it's public hostname as a CNAME record.

The package installs official Amazon packages only: `cloud-utils` system package provided by Amazon, as well as `awscli` pip Python package also provided by Amazon.

The script currently does not have any fault tollerance - so ensure all variables are defined properly both in the class as well in Amazon.

The following IAM policies should be created - we recommend creating a separate user for security reasons:

Ability to describe tags:

    {
      "Statement": [
        {
          "Sid": "Stmt1358183399710",
          "Action": [
            "ec2:DescribeTags"
          ],
          "Effect": "Allow",
          "Resource": [
            "*"
          ]
        }
      ]
    }

Ability to edit your Route53 Hosted Zone
*Be sure to replace YOUR_HOSTED_ZONE_ID_HERE with your Hosted Zone ID*

    {
       "Statement":[
          {
             "Action":[
                "route53:ChangeResourceRecordSets",
                "route53:GetHostedZone",
                "route53:ListResourceRecordSets"
             ],
             "Effect":"Allow",
             "Resource":[
                "arn:aws:route53:::hostedzone/YOUR_HOSTED_ZONE_ID_HERE"
             ]
          },
          {
             "Action":[
                "route53:ListHostedZones"
             ],
             "Effect":"Allow",
             "Resource":[
                "*"
             ]
          }
       ]
    }

