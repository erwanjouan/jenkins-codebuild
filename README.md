# jenkins-codebuild

## GitHub <-> CodeBuild Project connection
A GitHub PAT Token should be generated and added to Source configuration in CodeBuild Console.

## Get latest AMI id from Parameter store
https://aws.amazon.com/blogs/compute/query-for-the-latest-amazon-linux-ami-ids-using-aws-systems-manager-parameter-store/

## Jenkins on EC2

### One Guide
https://faun.pub/a-guide-on-how-to-install-jenkins-on-an-ec2-instance-ab9f17af7efa

### Official guide
https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/


### Manual Actions on Jenkins EC2 
- Add Jenkins "AWS CodeBuild" plugin (Manage Jenkins > Manage Plugins)
- Credentials
    - Add Github PAT as credential (kind: Username with Password) to avoid Github API Throttling
    - Add Creds for CodeBuild (kind: CodeBuild Credentials, AccessKey/Secret Key)
- Add Global pipeline with Github PAT credentials
- Make views
- Add projects

