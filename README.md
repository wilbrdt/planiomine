# Quick start guide

> Preliminary note:
>
> [`docker compose`](https://docs.docker.com/compose/) is required to run
> a redmine instance. Make sure it is installed first.

Clone this project, copy the backup .tar.gz file from Planio inside the `_input` 
repository.
To extract and dispatch files from backup, run the `bootstrap` Makefile 
target:

```
$ make bootstrap
```

To start the redmine + mySQL database stack, run the `run` Makefile target:

```
$ make run
```

This command will fetch redmine and mysql images from Docker Hub and execute
them.
You can then visit http://localhost:3000.

It will first ask you to sign in: the default user and password for a redmine
instance are admin/admin, but it will usually ask you to connect with a 
user from your old Planio instance.