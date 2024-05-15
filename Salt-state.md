https://docs.saltproject.io/en/getstarted/fundamentals/states.html

create `/srv/salt` directory if it doesn't exist

create a new salt state called nettools.sls as `/srv/salt/nettools.sls`:

```bash
install_network_packages:
  pkg.installed:
    - pkgs:
      - rsync
      - lftp
      - curl
```

On Salt master, run the following command to apply the nettools state to only one specified salt-minion:

```bash
salt 'salt-minion-2' state.apply nettools
```
or run the following command to apply the nettools state to all salt-minions:

```bash
salt "*" state.apply nettools
```
output would be something like this:


```bash
root@salt-master:/srv/salt# salt "*" state.apply nettools
salt-minion-2:
----------
          ID: install_network_packages
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 18:23:36.833430
    Duration: 77.649 ms
     Changes:

Summary for salt-minion-2
------------
Succeeded: 1
Failed:    0
------------
Total states run:     1
Total run time:  77.649 ms
salt-minion-1:
----------
          ID: install_network_packages
    Function: pkg.installed
      Result: True
     Comment: The following packages were installed/updated: lftp
              The following packages were already installed: rsync, curl
     Started: 18:23:36.635583
    Duration: 24104.747 ms
     Changes:
              ----------
              lftp:
                  ----------
                  new:
                      4.9.2-1build1
                  old:

Summary for salt-minion-1
------------
Succeeded: 1 (changed=1)
Failed:    0
------------
Total states run:     1
Total run time:  24.105 s

```




