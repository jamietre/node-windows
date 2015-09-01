###Setting up a linux VM

Sometimes it's just easier to do it on linux. With Vagrant it is trivially easy.

First, install [Vagrant](https://www.vagrantup.com/downloads.html). You need to have VirtualBox installed as well.

Run the following commands from a shell:

	vagrant init ubuntu/trusty32
    vagrant up
    ssh vagrant

There, you're in a linux machine. `/vagrant` points to your home directory.

#####What happens

The first line `vagrant init` generates a `Vagrantfile` which describes the characteristics of the VM. If you want to create multiple VMs, just make a subfolder for each.

`vagrant up` parses the file and downloads the VM image named. You might want to make changes - for example, the default RAM allocation on VirtualBox is 512M. Probably best to make it at least a gig. Edit `Vagrantfile`:

    config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      config.vm.synced_folder "/remote/c", "c:/"
    end

The last line connects you to the terminal, you're in.

If this is the first time you set up a VM you probably need to set up some basics. Luckily this is a lot easier than Windows. For Ubuntu, just do the following:


    curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash -
	sudo apt-get update
	sudo apt-get install --yes nodejs
	sudo apt-get install --yes build-essential
    sudo npm install -g npm@latest 
    sudo apt-get install git

Git seems to be a bit behind; you can add it from a better-maintained source as follows:

    sudo apt-get-repository ppa:http://ppa.launchpad.net/git-core/ppa/ubuntu
    sudo apt-get update
    sudo apt-get install git

This adds the repo at the URL to your list of allowable package sources; it publishes new versions of git.



Setup with Ubuntu:

curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash -
Then install with Ubuntu:

sudo apt-get install --yes nodejs