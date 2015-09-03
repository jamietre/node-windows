###Setting up a linux VM

Sometimes it's just easier to do it on linux. With Vagrant it is trivially easy.

If you don't have [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed, download & install it first.
Next install [Vagrant](https://www.vagrantup.com/downloads.html).

Run the following commands from a shell:

	vagrant init ubuntu/trusty32
    vagrant up
    ssh vagrant

There, you're in a linux machine. `/vagrant` points to the location where did this.

#####What happens

The first line `vagrant init` generates a `Vagrantfile` which describes the characteristics of the VM. If you want to create multiple VMs, just make a subfolder and `cd` into it before you start. You can only have one VM config per folder, so just use the file system to organize.

`vagrant up` parses the file and downloads the VM image named. You might want to make changes - for example, the default RAM allocation on VirtualBox is 512M. Probably best to make it at least a gig. Edit `Vagrantfile`:

    config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
	  # also sync my entire C drive
      config.vm.synced_folder "/remote/c", "c:/"
    end

If this is the first time you have run this particular VM you probably need to set up some basics. Luckily this is a lot easier than Windows. For Ubuntu, just do the following:

    #install node
    curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash -
	sudo apt-get update
	sudo apt-get install --yes nodejs
    #install compilers
	sudo apt-get install --yes build-essential
    #install npm
    sudo npm install -g npm@latest
    #install git 
    sudo apt-get install git

Git seems to be a bit behind in the default Ubuntu repository; you can add it from a better-maintained source as follows:

    sudo apt-get-repository ppa:http://ppa.launchpad.net/git-core/ppa/ubuntu
    sudo apt-get update
    sudo apt-get install git

This adds the repo at the URL to your list of allowable package sources; it publishes new versions of git.

You should be good to go now for most things. In linux, just be aware that by default you are logged in with an unprivileged account. For installing packages globally you generally need to `sudo` first, e.g.

    sudo npm install -g mocha
    sudo npm install -g sinopia