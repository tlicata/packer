I wanted to deploy my site. I like building my development
environments with Vagrant.

The people who created Vagrant also have a product called
Packer. Packer can be used to pre-assemble development environments
for Vagrant. It can also be used to pre-essemble production
environments Amazon EC2 (and many other
[platforms][packer-platforms]).

This experiment installs my project and its dependencies on both an
Amazon Machine Image and Vagrant environment that I can use for
hosting my production site or development environment, respectively.

Steps
-----

```sh
packer $ packer build example.json
```

This produces an AMI and a VirtualBox image.

The AMI can be found under the "My AMIs" section in the AWS Web
Console and be used to spin up and EC2 instance.

The VirtualBox image can be added to Vagrant's box list:

```sh
vagrant box add packer-made-vbox packer_virtualbox-iso_virtualbox.box
```

Then in a Vagrantfile elsewhere I can add the line

```sh
  config.vm.box = "packer-made-vbox"
```

and then I can launch a virtual machine based off the image I just
built that has my project pre-installed.

[vagrant]: https://www.vagrantup.com/
[packer]: https://www.packer.io/
[packer-platforms]: https://www.packer.io/intro/platforms.html
