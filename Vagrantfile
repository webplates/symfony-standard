# -*- mode: ruby -*-

dir = File.dirname(File.expand_path(__FILE__))

require 'yaml'
require "#{dir}/etc/vagrant/ruby/deep_merge.rb"

conf = YAML.load_file("#{dir}/etc/vagrant/config.yml.dist")

if File.file?("#{dir}/etc/vagrant/config.yml")
    custom = YAML.load_file("#{dir}/etc/vagrant/config.yml")
    conf.deep_merge!(custom)
end

Vagrant.require_version ">= 1.7"

# Check to determine whether we're on a windows or linux/os-x host,
# later on we use this to launch ansible in the supported way
# source: https://stackoverflow.com/questions/2108727/which-in-ruby-checking-if-program-exists-in-path-from-ruby
def which(cmd)
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each { |ext|
            exe = File.join(path, "#{cmd}#{ext}")
            return exe if File.executable? exe
        }
    end
    return nil
end

Vagrant.configure("2") do |config|

    config.vm.provider :virtualbox do |v|
        v.name = conf["name"]
        v.customize [
            "modifyvm", :id,
            "--name", conf["name"],
            "--memory", conf["memory"],
            "--natdnshostresolver1", "on",
            "--cpus", 1,
        ]
    end

    config.vm.box = "ubuntu/trusty64"
    config.vm.network :private_network, ip: "192.168.33.99" # Make sure to change the ansible inventory as well
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.synced_folder ".", "/var/www", type: "nfs" # The mount point is hardcoded everywhere
    config.vm.hostname = conf["hostname"]
    config.ssh.forward_agent = true

    # If ansible is in your path it will provision from your HOST machine
    # If ansible is not found in the path it will be instaled in the VM and provisioned from there
    if which('ansible-playbook')
        config.vm.provision "ansible" do |ansible|
            ansible.playbook = "#{dir}/etc/vagrant/ansible/playbook.yml"
            ansible.inventory_path = "#{dir}/etc/vagrant/ansible/inventories/dev"
            ansible.limit = 'all'
        end
    else
        config.vm.provision :shell, path: "#{dir}/etc/vagrant/ansible/windows.sh", args: [conf["hostname"]]
    end

    # Exec plugin allows to easily execute commands in Vagrant
    if Vagrant.has_plugin?("vagrant-exec")
        config.exec.commands '*', directory: '/var/www'
    end

    # Hostmanager adds the VM hostname to your hosts file
    if Vagrant.has_plugin?("vagrant-hostmanager")
        config.hostmanager.enabled = true
        config.hostmanager.manage_host = true
        config.hostmanager.ignore_private_ip = false
        config.hostmanager.include_offline = true
    end
end
