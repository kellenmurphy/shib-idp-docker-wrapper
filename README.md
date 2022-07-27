# shib-idp-docker-wrapper

My development environment for Shibboleth IDP, based upon the [@iay/shibboleth-idp-docker](https://github.com/iay/shibboleth-idp-docker) repository, my [fork](https://github.com/kellenmurphy/shibboleth-idp-docker) of which is included as a [submodule](https://github.blog/2016-02-01-working-with-submodules/). 

That means you'll want to use `--recursive` when cloning:

```
git clone --recursive https://github.com/kellenmurphy/shib-idp-docker-wrapper.git
```

You'll also do well to run:

```
git pull --recurse-submodules
```

every once in a while.  

> N.B. No promises this won't break if [@iay](https://github.com/iay) changes some things and I end up pulling them in to work on something. This is a **development** environment after all, so please take that as solid advice and don't use this in a production environment. If you want to run Shibboleth IDP in production using Docker, look at the [InCommon Trusted Access Platform](https://spaces.at.internet2.edu/display/ITAP/InCommon+Trusted+Access+Platform+Library) or [hire me](https://idmengineering.com) :smile:. As of July 2022, a known working commit from the [base repository][https://github.com/kellenmurphy/shibboleth-idp-docker] is: 

You'll need to have Docker installed on your local machine. I work on a Windows 10 Pro machine using Docker with the WSL2 backend, but this will presumably work on *nix. 

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

## deploy.sh and redeploy.sh

These scripts are also provided as intermediate deployment steps, or to re-deploy a configuration change.
## wrap.sh

Any of the scripts from [iay/shibboleth-idp-docker][https://github.com/iay/shibboleth-idp-docker] can be executed with overwritten `VERSIONS` settings with `wrap.sh` as, for example:

```bash
./wrap.sh install
```

will execute the installation. For the `install` command, we also override `install-idp` settings with a local file. I'm sure more changes are under way, but I wanted the simplest set of wrapper scripts I could get for the time being, so I can quickly spawn test instances on `idp.example.org`.

## Shibboleth Configuration

A `shibboleth-idp` directory exists at the root of this project which will overwrite the running config if files are provided, i.e. credentials.

# TODO

[ ] Bring over changes from [kellenmurphy/shib-docker](https://github.com/kellenmurphy/shib-docker) for Azure + WSL stuff.
[ ] Scripts for managing certs.