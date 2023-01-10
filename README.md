# Odoo module development test

## Development container

[Dev container](https://code.visualstudio.com/docs/devcontainers/tutorial) is enabled.

To start the application use the makefile (ex. `make start-odoo`). See all makefile targets with `make list`.

You can access the application on [localhost:4200](http://localhost:4200/) (you can always see the running apps in the "ports" tab of the container in VSCode).

User/password is `admin`/`admin`.

Your addons will not be installed automatically. That is on purpose; perhaps we can later add another script to do that.  
_(the workspaces directory is on the addons path, so they will be available for installation in Odoo Apps module)_

_"The settings app opens the users list, how do I get to General Settings?"_ - Install any module and the settings app will be available.

`Docker-from-docker` is installed, so you can actually also control you local docker from within the container. Including starting other docker-compose files, etc.

### Database

The database persists in a docker volume probably called `odoo_rs-devcontainer...`, see docker volumes.

If you'd like to reset the database, navigate to /web/database/manager and delete the database, then run `make install-odoo-db`.

### Odoo Enterprise

The dev container is configured to use Odoo Enterprise if you have the enterprise sources downloaded in the `.enterprise` directory (see the [.enterprise readme file](.enterprise/readme_enterprise.md)).

### SSH

Note that in order to use SSH from within the container, you need to enable the ssh-agent before starting the container.  
See [VSCode dev containers - sharing credentials](https://code.visualstudio.com/docs/remote/containers#_sharing-credentials-with-your-container) for more information.

```powershell
# Make sure you're running as Administrator
Set-Service ssh-agent -StartupType Automatic
Start-Service ssh-agent
Get-Service ssh-agent
# Add your SSH key(s) to the ssh-agent with ssh-add, eg:
# ssh-add ~/.ssh/id_rsa
# ssh-add ~/.ssh/id_ed25519
```

### Known issues with dev-container

- The git extension is much slower in the dev container than in local installation, not sure there's anything we can do about it.
- To avoid issues in Windows machines, the container has git configured to ignore file permissions. This can be changed by running `git config core.fileMode true` in the container. (see [here](https://stackoverflow.com/a/31986529/5651603) and [here](https://stackoverflow.com/a/65436208/5651603))
- Again about Windows compatibility, we run `dos2unix` on the workspace when starting the container. This can fix or cause `git status` to show several changed files that have no changes; staging these files should let git know that they are the same and just remove them from the "changed" list; but do check your staged changes before committing.

### to-do list for dev-container

- improved testing is under-way; we're already working well with it in the `7628_api_concept` branch, will take some of what is in progress there and merget it later
- maybe create a make target to install the addons
- some of Odoo code is not yet fully understood by the linter; we probably need some python stubs for Odoo (the original source code is not type annotated)

## References

- [(Odoo) Running tests](https://www.odoo.com/documentation/master/developer/reference/backend/testing.html#running-tests)
- [(Odoo) Command line](https://www.odoo.com/documentation/16.0/developer/cli.html#reference-cmdline-config)
- [(VScode) Creating dev containers](https://code.visualstudio.com/docs/devcontainers/create-dev-container)
- [(Odoo) Stop Odoo after tests](https://www.odoo.com/forum/help-1/run-unittests-in-pipeline-using-docker-170355)
