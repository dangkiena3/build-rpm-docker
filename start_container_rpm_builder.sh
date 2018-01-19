DOCKER_CONTAINER_NAME="rpm_builder"

DOCKER_CONTAINER_STATUS=$(docker inspect -f {{.State.Running}} $DOCKER_CONTAINER_NAME)

if [ $? -gt 0 ];
then
	echo "Starting Container $DOCKER_CONTAINER_NAME"
	docker run -it -v `pwd`:/build  --name rpm_builder --dns=8.8.8.8 dangkiena3/rpm-build-docker /bin/bash
else
	if [ $DOCKER_CONTAINER_STATUS = "false" ];
	then
		echo "Container is now starting."
		docker start $DOCKER_CONTAINER_NAME
	fi

	echo "Docker container $DOCKER_CONTAINER_NAME started. Press ENTER to continue"

	docker attach $DOCKER_CONTAINER_NAME

fi


