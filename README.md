# Symfony Standard Edition

> Welcome to the Symfony Standard Edition - a fully-functional Symfony2
> application that you can use as the skeleton for your new applications.

Well, this is not the original one, but still welcome to it. This is "my" Symfony Standard Edition.

The rationale behind creating a custom skeleton is simple:
put some extra logic in it which could still be required by any application which people might create.

**Important:** This is not a fork. Although this version is created based on the original one, it does note
have any connection to it. From time to time the content might be updated in order to adhere the latest-greatest
practices.

If you are looking for the original version, you can find it [here](https://github.com/symfony/symfony-standard).
However I suggest continue reading first as you might find a few interesting features you might want to use.


## What's inside?

### Symfony 3 directory structure

(**Note:** This is still **Symfony2**.)

Symfony 3 directory structure will be a bit different. For example `cache/` and `logs/` directories are moved
to a new directory called `var/`.
The [SensioDistributionBundle](https://github.com/sensiolabs/SensioDistributionBundle) has builtin support for this
from version *4.0* which is being used in Symfony *2.7*.


### Capistrano deployment

[Capistrano](http://capistranorb.com/) is

> A remote server automation and deployment tool written in Ruby.

according to its own description. Fortunately it has official Symfony support. A basic Capistrano deployment script
(with staging and production environments) is included.

**Note:** There is already also a Capistrano deployment plugin called [Capifony](http://capifony.org/)
created by @everzet, but it is Capistrano 2.x only. This deployment script uses Capistrano 3.x and the
official Symfony plugin.


#### Installed plugins

- [Symfony](https://github.com/capistrano/symfony)
- [Maintenance](https://github.com/capistrano/maintenance): Put your application in maintetnance mode.
(Utilizes webserver configuration, so requests does not even get to your application)
- [Airbrussh](https://github.com/mattbrictson/airbrussh): Pretty SSHKit and Capistrano logging
- [List stages](https://rubygems.org/gems/capistrano-list_stages): Lists all stages when `cap` is called without a stage.
- [Invoke](https://github.com/sakuro/capistrano-invoke): Invoke commands on remote servers.
- [Banner](https://github.com/holysugar/capistrano_banner): Add a custom banner to deployment.
- [Deploy Block](https://github.com/brigade/capistrano-deploy-block): Block deployment for others.
- [Env Config](https://github.com/rjocoleman/capistrano-env-config): Environment based configuration.
- [Pending](https://github.com/a2ikm/capistrano-pending): Check pending commits before deployment.
- [SSH Doctor](https://github.com/capistrano-plugins/capistrano-ssh-doctor): Debug SSH connection/agent.
- [Logtail](https://github.com/ydkn/capistrano-logtail): Tail log files from the server.
- [Notifications](https://github.com/scorix/capistrano-notifications/): Send notifications about deployments.
- [Secret](https://github.com/xavierpriour/capistrano-secret): Store secrets in separate configuration files.


### [Editorconfig](http://editorconfig.org/)

It is not really a feature of Symfony, but helps you writting code in the same style in any IDE.


## What's removed?

### Assetic

As of Symfony 3.0 Assetic will be removed. The reasoning behind can be checked here: symfony/symfony-standard#860

In the past few years it became clear that PHP will never be as popuplar as Node when it comes to frontend development.
This led to Assetic being removed in favor of...well, it's you choice. You can use any popular Node task runners:
Grunt, Gulp, Brunch, etc.


As in the original version, all libraries and bundles included in the Symfony Standard Edition are
released under the MIT or BSD license.

Enjoy!
