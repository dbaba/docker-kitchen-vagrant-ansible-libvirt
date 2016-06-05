#!/usr/bin/env bash

docker rmi docker-kitchen-vagrant-ansible-libvirt:latest

docker build -t docker-kitchen-vagrant-ansible-libvirt:latest .
