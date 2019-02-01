# AWS bastion host template
This CloudFormation template creates a typical AWS bastion, which has all essential software installed for DevOps projects.

Just run:
```
# aws cloudformation create-stack --stack-name MyBastionStack --template-body file://aws-bastion-template.json --parameters ParameterKey=KeyPairName,ParameterValue="MyKey" ParameterKey=VPCId,ParameterValue="MyVPCId" ParameterKey=SubnetId,ParameterValue="MySubnetId"
```

Please note that the bastion host in this template has administrator access. \
You should change bastion's permissions policy when deploying it to production.
