# shib-idp-docker-wrapper

My development environment for Shibboleth IDP, based upon @iay's handy shibboleth-idp-docker repository. 

## Quickstart

To get started quickly with a stock Shibboleth IDP running on localhost with the entityID: `https://idp.example.org/idp/shibboleth` simply run:

```bash
./quickstart.sh
```

You'll be asked to provide the export password for the self-signed certificate that's being generated for HTTPS, use 'changeit' to maintain compatibility with the defaults from [iay/shibboleth-idp-docker][https://github.com/iay/shibboleth-idp-docker].

To stop and then purge the container:

```bash
./wrap.sh stop
./purge
```

## deploy.sh and redeploy.sh

These scripts are also provided as intermediate deployment steps, or to re-deploy a configuration change.
## wrap.sh

Any of the scripts from [iay/shibboleth-idp-docker][https://github.com/iay/shibboleth-idp-docker] can be executed with overwritten `VERSIONS` settings with `wrap.sh` as, for example:

```bash
./wrap.sh install
```

will execute the installation. For the `install` command, we also override `install-idp` settings with a local file. I'm sure more changes are under way, but I wanted the simplest set of wrapper scripts I could get for the time being, so I can quickly spawn test instances on `idp.example.org`.

## TODO

[ ] Bring over changes from [kellenmurphy/shib-docker](https://github.com/kellenmurphy/shib-docker) for Azure + WSL stuff.