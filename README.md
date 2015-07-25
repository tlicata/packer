Using [Packer][packer] to build development and production
environments.

- VirtualBox image for launching a [Vagrant][vagrant]-based
development environment.
- Amazon Machine Image (AMI) for launching EC2 servers.

I use Vagrant at work to automate the process of setting up the
development environment. It installs the languages, databases, and
tools we need. It works well. One annoyance is that it still takes
a long time to run through all the installations (even if they are
automated).

The annoyance was that I ways always starting from a vanilla Ubuntu
image and building it up from scratch. Around the time I started
wondering how I could make my own base images I also started to wonder
how I could setup my servers in a similar way. Then I started reading
about Packer.

Packer can take Ubuntu, run my installation scripts, then snapshot the
results. Now, VirtualBox already had this capability, but Packer
generalizes it to many different [platforms][packer-platforms].

So this experiment installs my project on both an Amazon Machine Image
and a VirtualBox-hosted Ubuntu. It takes both of them and installs
Java, Git, Leiningen, and my project on each. Then a snapshot is
created and I can either spin up an EC2 server from it or add it as a
Vagrant base box and use it for my development environment.

Steps
-----

```sh
packer $ packer build example.json
```

This takes both the Amazon and the VirtualBox base images, runs my
installation scripts on them, and outputs the results. The AMI is
available under "My AMIs" if I login to my AWS Web Console and I can
use it to launch new EC2 instances. The VirtualBox is output as
`packer_virtualbox-iso_virtualbox.box` and I can add it to Vagrant to
be used as a base box.

```sh
vagrant box add packer-made-vbox packer_virtualbox-iso_virtualbox.box
```

Then in a Vagrantfile elsewhere I can add the line

```sh
Vagrant.configure(2) do |config|

  # ...
  config.vm.box = "packer-made-vbox"
  # ...

```

and then I can launch a virtual machine based off the image I just
built that has my project pre-installed.
