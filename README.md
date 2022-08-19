# jenkins-codebuild

Jenkins ECS/Fargate deployemnt with persistent EFS volume, widely inspired from https://tomgregory.com/deploy-jenkins-into-aws-ecs/

## Required manual actions:

### Github
- A GitHub PAT Token should be generated

### Jenkins
- Add Jenkins "AWS CodeBuild" plugin (Manage Jenkins > Manage Plugins)
- Configure credentials
    - Add Github PAT as credential (kind: Username with Password) to use Gihub source (avoid Github API Throttling, upload github status...)
    - Add Creds for CodeBuild (kind: CodeBuild Credentials, AccessKey/Secret Key)
- Add Jenkins shared libraries: https://github.com/erwanjouan/aws-jenkins-shared

### Notes:
- [Get latest AMI id from Parameter store](https://aws.amazon.com/blogs/compute/query-for-the-latest-amazon-linux-ami-ids-using-aws-systems-manager-parameter-store/)

