# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # set the chef version
  config.omnibus.chef_version = :latest

  config.vm.define "berkshelf-dev-vm" do |node|
    node.vm.hostname = "berkshelf-dev-vm"
    node.vm.box = "opscode_centos-6.4_provisionerless"
    node.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_centos-6.4_provisionerless.box"

    node.vm.synced_folder "../berkshelf", "/berkshelf"

    node.vm.provider :virtualbox do |vb|
      # Give enough horsepower to build without taking all day.
      vb.customize [
        "modifyvm", :id,
        "--memory", "1024",
        "--cpus", "2",
      ]
    end
    
    node.vm.provision :chef_solo do |chef|
      # Currently overriding git urls to work around firewall issues
      chef.json = {
        "berkshelf_dev_vm" => {
          "override_git_urls" => true
        },
        "rbenv" => {
          "git_repository" => "https://github.com/sstephenson/rbenv.git"
        },
        "ruby_build" => {
          "git_repository" => "https://github.com/sstephenson/ruby-build.git"
        }
      }
      chef.run_list = [
        "recipe[berkshelf-dev-vm]"
      ]
    end
  end
end
