PROJECT_NAME:= codebuild-jenkins-slave

start:
	docker-compose up #-d
stop:
	docker-compose down
logs:
	docker logs jenkins | less

deploy:
	aws cloudformation deploy \
		--capabilities CAPABILITY_NAMED_IAM \
		--template-file ./cloudformation.yml \
		--stack-name $(PROJECT_NAME) \
		--parameter-overrides \
			ProjectName=${PROJECT_NAME}
destroy:
	aws cloudformation delete-stack \
        --stack-name $(PROJECT_NAME)
