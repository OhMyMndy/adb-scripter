IMAGE_NAME = ohmymndy/adb-scripter:latest
PROJECT_NAME = adb-scripter

ANDROID_VOLUME = $$HOME/.android:/root/.android

#DOCKER_RUN_OPTS = --network host --init 
DOCKER_RUN_OPTS = -v /var/run/udev:/var/run/udev --net=host --privileged --device /dev:/dev 

build:
	docker build --build-arg $(shell cat .arch 2>/dev/null || echo 'A=') -t $(IMAGE_NAME)$(IMAGE_NAME_ARCH) .

buildx:
	 docker buildx build --load --build-arg ARCH=arm32v5/ --platform linux/arm32v6 -t $(IMAGE_NAME)_arm32v6 .

run: destroy
	docker run --rm -it $(DOCKER_RUN_OPTS) --name $(PROJECT_NAME) -v "$(ANDROID_VOLUME)" $(IMAGE_NAME)$(IMAGE_NAME_ARCH) /adb-scripter/bin/adb-scripter

destroy:
	docker kill $(PROJECT_NAME) || true
	docker rm $(PROJECT_NAME) || true

run-with-restart: destroy
	docker run -d $(DOCKER_RUN_OPTS) --name $(PROJECT_NAME) --restart unless-stopped -v "$(ANDROID_VOLUME)" $(IMAGE_NAME)$(IMAGE_NAME_ARCH)

run-shell:
	docker run --rm $(DOCKER_RUN_OPTS) -it -v "$(ANDROID_VOLUME)"  $(IMAGE_NAME)$(IMAGE_NAME_ARCH) ash

run-udevadm:
	docker run --rm $(DOCKER_RUN_OPTS) -it -v "$(ANDROID_VOLUME)" $(IMAGE_NAME)$(IMAGE_NAME_ARCH) udevadm monitor -p

deploy:
	ansible-playbook ansible/local.yml -k -i $(IP),

deploy-image: buildx
	docker save $(IMAGE_NAME)_arm32v6 | ssh $(HOST) docker load
