# There is a comment here

mountpath = 'nothing'

util = require 'util'
exec = require('child_process').exec

# this is a change

mountpath = "/home/wagoodman/.atom/mounts/localhost/tmp"
hostname = "localhost"
directory = "/tmp"
username = "wagoodman"
keyfile = "/home/wagoodman/.ssh/id_rsa"

command = util.format "sshfs -o IdentityFile=%s -o cache=yes -o StrictHostKeyChecking=no %s@%s:%s %s", keyfile, username, hostname, directory, mountpath
exec command, (error, stdout, stderr) ->
   console.log [error, stdout, stderr]
