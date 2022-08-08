PROJECT_NAME:= codebuild-jenkins-slave

local-start:
	docker-compose up #-d

local-stop:
	docker-compose down

local-logs:
	docker logs jenkins | less

deploy:
	aws cloudformation deploy \
		--capabilities CAPABILITY_NAMED_IAM \
		--template-file ./cloudformation.yml \
		--stack-name $(PROJECT_NAME) \
		--parameter-overrides \
			ProjectName=${PROJECT_NAME} \
			TimeStamp=$$(date +%s) # Forces update

destroy:
	aws s3 rm s3://$(PROJECT_NAME)-output --recursive && \
	aws cloudformation delete-stack \
        --stack-name $(PROJECT_NAME)

remote-stop:
	aws ecs update-service --cluster $(PROJECT_NAME) --service $(PROJECT_NAME) --desired-count 0 --query "service.desiredCount"
