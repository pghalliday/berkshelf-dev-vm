berkshelf-dev-vm
================

Vagrant development environment for working on Berkshelf source.

Prerequisites
-------------

Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](http://downloads.vagrantup.com/)

Install the `vagrant-berkshelf` and `vagrant-omnibus` plugins

    $ vagrant plugin install vagrant-berkshelf
    $ vagrant plugin install vagrant-omnibus

Usage
-----

First clone the `berkshelf` and `berkshelf-dev-vm` projects (or your own forks) to your host machine in the same directory, then switch to the `berkshelf-dev-vm` directory.

```
$ git clone https://github.com/RiotGames/berkshelf.git
$ git clone https://github.com/pghalliday/berkshelf-dev-vm.git
$ cd berkshelf-dev-vm
```

then run

```
$ vagrant up
```

This will install all prerequisites, map the `berkshelf` working directory and run `bundle install`

Connect to the vagrant instance

```
$ vagrant ssh
```

Change to the berkshelf project directory

```
[vagrant@berkshelf-dev-vm ~]$ cd /berkshelf/
```

Then to start guard

```
[vagrant@berkshelf-dev-vm berkshelf]$ bundle exec guard start -n f
```

The `-n f` option is required to turn off notifications as these are not supported with vagrant