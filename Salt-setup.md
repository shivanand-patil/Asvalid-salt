https://docs.saltproject.io/en/getstarted/fundamentals/install.html

## On the Salt Master

Run these commands on the system that you want to use as the central management point (Salt-Master):

```bash
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sudo sh install_salt.sh -M
```

(note the -M option for "install Salt master")

## On each Salt Minion

Run these commands on each system that you want to manage using Salt ( Salt-Minion(s) ).
```bash
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sudo sh install_salt.sh
```

On each Salt minion edit `/etc/salt/minion` conf and add following line 

```bash
master: <master-ip>
```

and restart salt-minion using this command:

```bash
systemctl restart salt-minion
```

On master, edit `/etc/salt/master` conf and all the following line:

```bash
interface: <master-ip>
```

Now check accepted servers on salt-master node by running:

```bash
salt-key --list-all
```
To allow all keys, run:

```bash
salt-key --accept-all
```

## Test the Master-Minion connection

run following command:

```bash
salt '*' test.ping
```

The output will be something like this:

```bash
salt-minion-2:
    True
salt-minion-1:
    True
```


run following command:
```bash
salt '*' cmd.run "df -H"
```

The output will be something like this:

```bash
salt-minion-2:
    Filesystem      Size  Used Avail Use% Mounted on
    tmpfs           206M  1.1M  205M   1% /run
    /dev/sda1        11G  2.0G  8.3G  20% /
    tmpfs           1.1G   13k  1.1G   1% /dev/shm
    tmpfs           5.3M     0  5.3M   0% /run/lock
    /dev/sda15      110M  6.4M  104M   6% /boot/efi
    tmpfs           206M  4.1k  206M   1% /run/user/1000
salt-minion-1:
    Filesystem      Size  Used Avail Use% Mounted on
    tmpfs           206M  1.1M  205M   1% /run
    /dev/sda1        11G  2.0G  8.3G  20% /
    tmpfs           1.1G   13k  1.1G   1% /dev/shm
    tmpfs           5.3M     0  5.3M   0% /run/lock
    /dev/sda15      110M  6.4M  104M   6% /boot/efi
    tmpfs           206M  4.1k  206M   1% /run/user/1000
```
