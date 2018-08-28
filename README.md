# A typical AWS bastion host
This project builds a typical AWS bastion, which has all essential software for DevOps projects.

Just run:
``` $ aws cloudformation create-stack ``` 

_(The template builds an EC2 instance, downloads "setup-typical-bastion.sh" and runs it. \
Please be aware that it also creates the IAM role for the bastion to access all AWS services. \
Please review the IAM role before deploying to production.)_: \

You can update and run the setup script locally any time as shown below: \
``` $ sudo /opt/typical-aws-bastion/setup-typical-bastion.sh ```

Tested on CentOS 7.
