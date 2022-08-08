PROJECT_NAME:=codebuild-jenkins-slave
JENKINS_PORT:=8080
BROWSER:=firefox

local-start:
	docker-compose up #-d

local-stop:
	docker-compose down

local-logs:
	docker logs jenkins | less

start:
	aws cloudformation deploy \
		--capabilities CAPABILITY_NAMED_IAM \
		--template-file ./cloudformation.yml \
		--stack-name $(PROJECT_NAME) \
		--parameter-overrides \
			ProjectName=$(PROJECT_NAME) \
			JenkinsPort=$(JENKINS_PORT) \
			TimeStamp=$$(date +%s) # Forces update

destroy:
	aws s3 rm s3://$(PROJECT_NAME)-output --recursive && \
	aws cloudformation delete-stack \
        --stack-name $(PROJECT_NAME)

open:
	JENKINS_PUBLIC_IP=$$(aws cloudformation describe-stacks \
		--stack-name $(PROJECT_NAME) \
		--query "Stacks[0].Outputs[?OutputKey=='JenkinsPublicIp'].OutputValue" --output text) && \
	$(BROWSER) http://$${JENKINS_PUBLIC_IP}:$(JENKINS_PORT)

stop:
	aws ecs update-service --cluster $(PROJECT_NAME) --service $(PROJECT_NAME) --desired-count 0 --query "service.desiredCount"
