# Vagrant-PHP7

Vagrant Configuration with NGNIX, MySQL, and PHP7!
***

### Configuration

##### Vagrantfile
This is a pretty standard config. You'll want to change a couple basic things like ```forwarded_port``` and ```synced_folder```

##### bootstrap.sh
It goes without saying you should **ALWAYS** read through a bash script, especially one that is going to execute as root, even if it is for a virtual machine...

That said a couple notes on this one:

  - Update the password for MySQL in the ```Preparing MySQL``` Section, where ```1234``` is the password
  - If you don't want MySQLs ```bind-address``` to be 0.0.0.0, then you'll want to remove the line that sets it under ```Configuring MySQL```
  ```bash
  sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/my.cnf
  ```
  - When The script runs it's going to copy the files in ```/provision``` to their respective directories. So any changes to ```php.ini```, ```my.cnf```, or ```nginx_vhost``` should be made before running this.

### Lets Turn it Up!
Before you start you'll need the "ubuntu/trusty32" box

```bash
 $ vagrant box add ubuntu/trusty32
```

Then just run the standard up command for vagrant in the dir you want this to be.

```bash
$ vagrant up
```

#### Disclaimer

I built this for myself and just figured I'd share. It's very possible there's better ways to do some of the things here and if you notice any let me know! That said you should understand what's going on here and use at your own risk.


