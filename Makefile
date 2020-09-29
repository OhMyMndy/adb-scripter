build:
	docker build --build-arg $(shell cat .arch 2>/dev/null) -t ohmymndy/adb-scripter:latest .

buildx:
	 docker buildx build --build-arg ARCH=arm32v5/ --platform linux/arm32v6 -t ohmymndy/adb-scripter:latest_arm32v6 .

run:
	docker run --rm -it -v /dev:/dev:ro ohmymndy/adb-scripter:latest 

run-with-restart:
	docker stop adb-scripter || true
	docker kill adb-scripter || true
	docker run -d --init --name adb-scripter --restart unless-stopped -v /dev:/dev:ro ohmymndy/adb-scripter:latest

run-shell:
	docker run --rm --init -it -v /dev:/dev:ro ohmymndy/adb-scripter:latest ash

run-udevadm:
	docker run --rm --init -it -v /dev:/dev:ro ohmymndy/adb-scripter:latest udevadm monitor -p
