# pp_test_automation

This is the automation repository for the PebblePost interview test.  To run this you will need to have terraform and AWS CLI locally installed and configured to your AWS account.  To build and deploy the application please run the following commands in a terminal in this repo.  You will most likely be prompted to enter a value for the Subnet ID and VPC ID.  These can be left blank for this test case and you can just hit enter.

```
terraform init  #initialize the terraform setup, may take a few minutes
terraform plan  #run the terraform plan to make sure the script will operate properly
terraform apply #runs the script applying the automation to AWS, it will ask you if you'd like to perform these actions please type in 'yes' and press enter
```

The application will take approximately 5 mintues to setup, initialize and deploy.  After 5 minutes you can then go to your AWS interface and find your new EC2 instance running.  Copy the 'Auto-assigned IP address' and replace IP_ADDRESS with it in the url below.  Replace the text NUMBER with the number you would like to validate and a simple page will be returned with the desired response.

http://IP_ADDRESS/isFibonacci/NUMBER