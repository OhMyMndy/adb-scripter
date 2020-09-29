IMAGE_NAME = ohmymndy/adb-scripter:latest
PROJECT_NAME = adb-scripter

build:
	docker build --build-arg $(shell cat .arch 2>/dev/null || echo 'A=') -t $(IMAGE_NAME) .

buildx:
	 docker buildx build --load --build-arg ARCH=arm32v5/ --platform linux/arm32v6 -t $(IMAGE_NAME)_arm32v6 .

run: destroy
	docker run --rm -it --init --name $(PROJECT_NAME) -v /dev:/dev:ro $(IMAGE_NAME) 

destroy:
	docker kill $(PROJECT_NAME) || true

run-with-restart: destroy
	docker run -d --init --name $(PROJECT_NAME) --restart unless-stopped -v /dev:/dev:ro $(IMAGE_NAME)

run-shell:
	docker run --rm --init -it -v /dev:/dev:ro $(IMAGE_NAME) ash

run-udevadm:
	docker run --rm --init -it -v /dev:/dev:ro $(IMAGE_NAME) udevadm monitor -p

deploy:
	ansible-playbook ansible/local.yml -k -i $(IP),

deploy-image: buildx
	docker save $(IMAGE_NAME)_arm32v6 | ssh $(HOST) docker load
