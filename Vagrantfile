Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.provision :shell, path: "bootstrap.sh"
    config.vm.provider "virtualbox" do |v|
        v.name = "yawp-perf"
        v.memory = 2048
        v.cpus = 2
        v.customize [ "guestproperty", "set", :id, "--timesync-threshold", 10000 ]
    end
    config.vm.synced_folder ".", "/home/vagrant/repo", owner: "vagrant", group: "vagrant"
    config.vm.synced_folder ENV['HOME'] + "/.m2", "/home/vagrant/.m2", owner: "vagrant", group: "vagrant"
end
