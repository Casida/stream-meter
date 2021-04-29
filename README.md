# stream-meter #
Visualizer for stream data from a sensor datalog to a gauge display and stepper driver.

_Note_: **.gitlab-ci.yml** file has been removed to move this over to GitHub, so build and deployment steps need to be handled manually.

### Docker Image Deployment (manual) ###

```
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 817461044341.dkr.ecr.us-east-2.amazonaws.com
docker build -t stream-meter .
docker tag stream-meter:latest 817461044341.dkr.ecr.us-east-2.amazonaws.com/stream-meter:latest
docker push 817461044341.dkr.ecr.us-east-2.amazonaws.com/stream-meter:latest
```

### Terraform Build (manual) ###

```
cd terraform
terraform init
terraform apply
```

### Load Balancer URL ###

http://stream-meter-alb-2027286141.us-east-2.elb.amazonaws.com/
