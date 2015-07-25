I wanted to deploy a site. I like building development environments
with Vagrant.

The people who created [Vagrant][vagrant] also have a product called
[Packer][packer]. Packer can be used to pre-assemble development
environments for Vagrant. It can also be used to pre-assemble
production environments for Amazon EC2 (and many other
[platforms][packer-platforms]).

This experiment installs my project on both an Amazon Machine Image
and a Vagrant box for use as my production and development
environments, respectively.

The Vagrant related steps were largely inspired by Shiguredo's
[packer-templates][packer-templates].

Steps
-----

```sh
packer build example.json
```

This produces an AMI and a VirtualBox image.

The AMI can be found under the "My AMIs" section in the AWS Web
Console and be used to spin up EC2 instances.

The VirtualBox image can be added to Vagrant's box list:

```sh
vagrant box add packer-made-vbox packer_virtualbox-iso_virtualbox.box
```

Then in a Vagrantfile elsewhere I can add the line

```sh
config.vm.box = "packer-made-vbox"
```

and then I can launch a virtual machine based off the image that
packer just built.

[vagrant]: https://www.vagrantup.com/
[packer]: https://www.packer.io/
[packer-platforms]: https://www.packer.io/intro/platforms.html
[packer-templates]: https://github.com/shiguredo/packer-templates
