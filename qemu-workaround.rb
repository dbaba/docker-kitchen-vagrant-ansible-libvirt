Vagrant.configure("2") do |c|
  c.vm.provider :libvirt do |p|
    p.driver = "qemu" # In order to avoid kitchen-vagrant's wrong expansion, i.e. { :name => "qemu" }
  end
end
