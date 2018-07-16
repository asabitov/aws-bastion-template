# A typical AWS bastion host
This script helps to configure a typical AWS bastion host and install all essential software for DevOps projects in AWS.

Procedure:
* run this script locally on your new AWS bastion host
* assign the proper IAM role for the bastion to manage AWS resources 

#### Why am I not using EC2 instance's user data to configure my bastions?
Because let's say I am working on some project on one of my bastions and I need to install just one little utility, which I plan to use everywhere in the future. So should I terminate all current working bastions on all my AWS accounts and rebuild them from the scratch? I can, but it is a waste of time, much easier will be adding that utility to this script, commit changes and run it when I start working on any particular bastion. Keep things simple.

Tested on CentOS 7.
