docker-kitchen-vagrant-ansible-libvirt
===

[![GitHub release](https://img.shields.io/github/release/dbaba/docker-kitchen-vagrant-ansible-libvirt.svg)](https://github.com/dbaba/docker-kitchen-vagrant-ansible-libvirt/releases/latest)
[![License MIT](https://img.shields.io/github/license/dbaba/candy-red.svg)](http://opensource.org/licenses/MIT)

A docker image for running test kitchen with Vagrant and libvirt

# How to use

## Prior to starting

    (host) $ docker pull dbaba/docker-kitchen-vagrant-ansible-libvirt
    (host) $ systemctl start libvirtd

## Start Test Kitchen

    (host) $ cd your-.kitchen.yml-folder
    (host) $ docker run -ti --rm \
        --privileged=true --net=host \
        -v $(pwd):/app \
        -v ${HOME}/.vagrant.d/boxes:/root/.vagrant.d/boxes \
        -v /var/lib/libvirt:/var/lib/libvirt \
        -v /var/run/libvirt:/var/run/libvirt \
        dbaba/docker-kitchen-vagrant-ansible-libvirt kitchen test

# Test Kitchen with libvirt Tips

## Use `qemu-workaround.rb` in order to set `config.vm.provider.driver="qemu"`

Unfortunately, kitechen-vagrant failed to interpret the following `customize` definition, which means you cannot choose either `qemu` or `kvm` to `driver` attribute of the libvirt driver.
```
driver:
  name: vagrant
  provider: libvirt
  customize:
    driver: qemu
```

Instead, use `vagrantfiles` attribute and `qemu-workaround.rb` file as shown below.
```
---
driver:
  name: vagrant
  provider: libvirt
  vagrantfiles:
    - qemu-workaround
```

You can prepend a relative path to a vagrant file name, e.g. files/qemu-workaround.

## Start Vagrant

    (host) $ cd your-vagrantfile-folder
    (host) $ docker run -ti --rm \
        --privileged=true --net=host \
        -v $(pwd):/app \
        -v $(pwd)/.vagrant.d/boxes:/root/.vagrant.d/boxes \
        -v /var/lib/libvirt:/var/lib/libvirt \
        -v /var/run/libvirt:/var/run/libvirt \
        dbaba/docker-kitchen-vagrant-ansible-libvirt vagrant up

# How to build

    (host) $ ./build.sh

# References

 * [docker-vagrant-libvirt](https://github.com/twiest/docker-vagrant-libvirt)
 * [vagrant-libvirt](https://github.com/vagrant-libvirt/vagrant-libvirt)
 * [Vagrantfile.erb template file in kitchen-vagrant](https://github.com/test-kitchen/kitchen-vagrant/blob/master/templates/Vagrantfile.erb)

# Revision History

* 1.0.2
    - Skip to remove gcc in order for gem to use it

* 1.0.1
    - Fix an issue where gem complained of building native extensions

* 1.0.0
    - Initial Release
