# shib-idp-docker-wrapper

My development environment for Shibboleth IDP, based upon the [@iay/shibboleth-idp-docker](https://github.com/iay/shibboleth-idp-docker) repository, my [fork](https://github.com/kellenmurphy/shibboleth-idp-docker) of which is included as a [submodule](https://github.blog/2016-02-01-working-with-submodules/). 

That means you'll want to use `--recursive` when cloning:

```
git clone --recursive https://github.com/kellenmurphy/shib-idp-docker-wrapper.git
```

You'll also do well to run this every once in a while:

```
git pull --recurse-submodules
```  

> N.B. No promises this won't break if [@iay](https://github.com/iay) changes some things and I end up pulling them in to work on something. This is a **development** environment after all, so please take that as solid advice and don't use this in a production environment. If you want to run Shibboleth IDP in production using Docker, look at the [InCommon Trusted Access Platform](https://spaces.at.internet2.edu/display/ITAP/InCommon+Trusted+Access+Platform+Library) or [hire me](https://idmengineering.com) :smile:.  
 
A known working commit for Shibboleth IDP v4.1.2 with Jetty 10 is commit [#b534346](https://github.com/kellenmurphy/shibboleth-idp-docker/commit/b534346f244f3018bf2ae48988c2babfee995c5b) from the base repository. (To check out this commit, just `cd shibboleth-idp-docker && git checkout <commit hash>`).

### Prerequisites

You'll need to have Docker installed on your local machine. I work on a Windows 10 Pro machine using Docker with the WSL2 backend, but this will presumably work on *nix. Also, in order to access any of the IDP webpages w/in a browser, you'll need to [modify your local hosts file](https://www.bcsengineering.com/how-to-modify-your-hosts-file/) to point the hostname you use (by default, `idp.example.org`) to localhost: `127.0.0.1`, e.g.

```
127.0.0.1 idp.example.org
```
# Scripts

## quickstart.sh

To get started quickly with a stock Shibboleth IDP running on `localhost` with the entityID: `https://idp.example.org/idp/shibboleth` simply run:

```bash
./quickstart.sh
```

You'll be asked to provide the export password for the self-signed certificate that's being generated for the userfacing (browser) TLS certificate, use 'changeit' to maintain compatibility with the defaults from the [base repository][https://github.com/kellenmurphy/shibboleth-idp-docker].

## purge.sh

To stop and then purge the container:

```bash
./purge.sh
```

This uses [#wrap.sh] to stop the running container, remove the files created within the [base repository][https://github.com/kellenmurphy/shibboleth-idp-docker] that are created when pulling down Jetty and Shib IDP, as well as logs from the previous container execution.

## deploy.sh & redeploy.sh

These scripts are also provided as intermediate deployment steps, or to re-deploy a configuration change. If you've stopped a container, i.e. with `./wrap.sh stop` you can use `deploy.sh` to restart it, but generally you'll just use `redeploy.sh`. Think of this as restarting Jetty.
## wrap.sh

Any of the scripts from [iay/shibboleth-idp-docker](https://github.com/iay/shibboleth-idp-docker) can be executed with overwritten `VERSIONS` settings with `wrap.sh` as, for example:

```bash
./wrap.sh install
```

will execute the installation. For the `install` command, we also override `install-idp` settings with a local file. I'm sure more changes are under way, but I wanted the simplest set of wrapper scripts I could get for the time being, so I can quickly spawn test instances on `idp.example.org`. 

Not all of the commands in the [base repository](https://github.com/iay/shibboleth-idp-docker) necessarily need to be "wrap'd"... but since you never know for sure which scripts are `source`-ing some of the environment files, it's better safe than sorry to `wrap` it.

### Scripts you can (and should) run with `wrap`:

- `aacli` - Run the [`aacli` tool](https://shibboleth.atlassian.net/wiki/spaces/IDP4/pages/1265631852/AACLI) inside the running container.
- `build` - Builds the container image. (Arguments to this script are passed to the underlying "docker build" command.)
- `cleanup` - Removes untagged containers and images.
- `console` - Spawns shell for running container.
- `fetch-jetty` - Fetches whatever version of Jetty is specified in `VERSIONS`.
- `fetch-shib`- Fetches whatever version of Shibboleth is specified in `VERSIONS`.
- `install` - Executes the Shibboleth `install.sh` from a downloaded Shibboleth distribution and builds the WAR file.
- `module` - Run the module command inside a stand-alone container, don't run with main container running. Used to add module components/config to `$IDP_HOME`.
- `reload-service` - Run the `reload-service.sh` script inside the running container for reloading Shibboleth services (i.e. `./wrap.sh reload-service -id shibboleth.AttributeFilterService`).
- `run` - Runs the container.
- `terminate` - Kills the running container.
- `test` - Run in a test mode which terminates and is removed on <kbd>ctrl</kbd>+<kbd>c</kbd>. Valuable for determining why, for example, IDP may not be starting / container dies and restarts over and over.

## Shibboleth Configuration

A `shibboleth-idp` directory exists at the root of this project which will overwrite the running config if files are provided, i.e. credentials. I usually symlink `shibboleth-idp` somewhere handy for storing a particular projects configuration data. This directory is listed in `.gitignore` so you don't accidentally add your secrets.propterties to a fork on this wrapper project. That's **never** happened. :wink:

## Logs

Jetty logs can be found in `./shibboleth-idp-docker/logs/jetty` and IDP logs in `./shibboleth-idp-docker/shibboleth-idp/logs`. The script `tail-logs.sh` will `tail -f` both th`e jetty.log` file and the `idp-process.log` file.

---
# To-do List

- [ ] Bring over changes from [kellenmurphy/shib-docker](https://github.com/kellenmurphy/shib-docker) for Azure + WSL stuff, as different branches.
- [ ] Re-factor as `ansible` playbook.
- [ ] Create scripts for managing certs.
- [ ] Move configuration into `overlay` directory to allow for customization of `metadata` and `view` directories in `shibboleth-idp`