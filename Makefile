build:
	docker build -t ohmymndy/adb-scripter:latest .

run:
	docker run --rm -it -v /dev:/dev:ro ohmymndy/adb-scripter:latest

run-with-restart:
	docker run --rm -d --restart unless-stopped -v /dev:/dev:ro ohmymndy/adb-scripter:latest

run-shell:
	docker run --rm -it -v /dev:/dev:ro ohmymndy/adb-scripter:latest ashma

run-udevadm:
	docker run --rm -it -v /dev:/dev:ro ohmymndy/adb-scripter:latest udevadm monitor -p