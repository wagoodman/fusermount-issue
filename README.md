# fusermount-issue package

This is an atom package. This package attempts to use sshfs installed on your system to mount a remote directory to a local mountpoint. The parameters are hard coded in lib/fusermount-issue.coffee:
```
  mountpath = "/home/wagoodman/.atom/mounts/localhost/tmp"
  hostname = "localhost"
  directory = "/tmp"
  username = "wagoodman"
  keyfile = "/home/wagoodman/.ssh/id_rsa"
```
Change these parameters as needed (user, paths, etc...). Essentially the command that the package runs is this:
```
  sshfs -o IdentityFile=[KEYFILE] -o cache=yes -o StrictHostKeyChecking=no [USERNAME]@[HOSTNAME]:[DIRECTORY] [MOUNTPOINT]
```
So in the above example:
```
  sshfs -o IdentityFile=/home/wagoodman/.ssh/id_rsa -o cache=yes -o StrictHostKeyChecking=no wagoodman@localhost:/tmp /home/wagoodman/.atom/mounts/localhost/tmp
```

After loading the module the issue can be reproduced by hitting Ctrl+Alt+O to see the issue. You should see an error indicating that:

```
fusermount: mount failed: Operation not permitted
```
The specific issue can be seen in the developer tools bar (in the console).
