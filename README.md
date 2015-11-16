[Packer][packer] can assemble development environments for
[Vagrant][vagrant]. It can also assemble production environments for
Amazon EC2 (and other [platforms][packer-platforms]).

This installs a project on both an Amazon Machine Image and a Vagrant
box for use as production and development environments, respectively.

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

[vagrant]: https://www.vagrantup.com/
[packer]: https://www.packer.io/
[packer-platforms]: https://www.packer.io/intro/platforms.html
