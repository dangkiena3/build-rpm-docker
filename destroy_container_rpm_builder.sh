DOCKER_CONTAINER_NAME="rpm_builder"

DOCKER_CONTAINER_STATUS=$(docker inspect -f {{.State.Running}} $DOCKER_CONTAINER_NAME)

if [ $? -gt 0 ];
then
	echo "Container $DOCKER_CONTAINER_NAME has been destroyed before."  
else

	docker rm $DOCKER_CONTAINER_NAME
	echo "OK. Container $DOCKER_CONTAINER_NAME is destroyed."  

fi
