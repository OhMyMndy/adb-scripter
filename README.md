# adb-scripter

Run ADB commands on the press of a button! Designed for Raspberry Pi (Zero)

## Install Ansible on Host

For Ubuntu:

```shell
sudo apt update
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
```

## Prepare SD Card

- Flash the [Raspberry Pi OS Lite](https://www.raspberrypi.org/downloads/raspberry-pi-os/) iso onto an Micro SD card
- Add the SSH file to the boot partition `touch /media/$USER/boot/ssh`

## Install software

- Install sshpass on your host (`apt-get install -y sshpass`)
- Install python3 on your Raspberry Pi (`apt-get install -y python3`)
- `make IP=<ip address> deploy`

## Build image locally

- Run `make buildx`
- Import the image on the target machine through ssh `docker save ohmymndy/adb-scripter:latest_arm32v6 | ssh <user@host> docker load`
