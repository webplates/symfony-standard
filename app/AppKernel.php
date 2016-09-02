<?php

use Symfony\Component\Config\ConfigCache;
use Symfony\Component\HttpKernel\Kernel;
use Symfony\Component\Config\Loader\LoaderInterface;

class AppKernel extends Kernel
{
    public function registerBundles()
    {
        $bundles = [
            new Symfony\Bundle\FrameworkBundle\FrameworkBundle(),
            new Symfony\Bundle\SecurityBundle\SecurityBundle(),
            new Symfony\Bundle\TwigBundle\TwigBundle(),
            new Symfony\Bundle\MonologBundle\MonologBundle(),
            new Symfony\Bundle\SwiftmailerBundle\SwiftmailerBundle(),
            new Doctrine\Bundle\DoctrineBundle\DoctrineBundle(),
            new Doctrine\Bundle\MigrationsBundle\DoctrineMigrationsBundle(),
            new Sensio\Bundle\FrameworkExtraBundle\SensioFrameworkExtraBundle(),

            new Lexik\Bundle\MaintenanceBundle\LexikMaintenanceBundle(),
            new Liip\MonitorBundle\LiipMonitorBundle(),

            new AppBundle\AppBundle(),
        ];

        if (in_array($this->getEnvironment(), ['dev', 'test'])) {
            $bundles[] = new Symfony\Bundle\DebugBundle\DebugBundle();
            $bundles[] = new Symfony\Bundle\WebProfilerBundle\WebProfilerBundle();
            $bundles[] = new Sensio\Bundle\DistributionBundle\SensioDistributionBundle();
            $bundles[] = new Sensio\Bundle\GeneratorBundle\SensioGeneratorBundle();
            $bundles[] = new Fidry\PsyshBundle\PsyshBundle();
            $bundles[] = new Liip\FunctionalTestBundle\LiipFunctionalTestBundle();
            $bundles[] = new Hautelook\AliceBundle\HautelookAliceBundle();
        }

        return $bundles;
    }

    public function getRootDir()
    {
        return __DIR__;
    }

    public function getCacheDir()
    {
        if ('vagrant' === getenv('USER')) {
            return '/opt/symfony/cache/'.$this->getEnvironment();
        }

        return dirname(__DIR__).'/var/cache/'.$this->getEnvironment();
    }

    public function getLogDir()
    {
        if ('vagrant' === getenv('USER')) {
            return '/opt/symfony/logs';
        }

        return dirname(__DIR__).'/var/logs';
    }

    public function registerContainerConfiguration(LoaderInterface $loader)
    {
        $loader->load($this->getRootDir().'/config/config_'.$this->getEnvironment().'.yml');

        // @see https://github.com/symfony/symfony/issues/7555
        $loader->load(function(\Symfony\Component\DependencyInjection\Container $container) {
            $container->getParameterBag()->add($this->getEnvParameters());
        });
    }

    /**
     * Recompiles the container without warming up the whole cache.
     *
     * Can be called upon docker container start to inject custom parameters.
     */
    public function compile()
    {
        // Load class cache
        if ($this->loadClassCache) {
            $this->doLoadClassCache($this->loadClassCache[0], $this->loadClassCache[1]);
        }

        // Initialize bundles to be able to parse configurations
        $this->initializeBundles();

        $class = $this->getContainerClass();
        $cache = new ConfigCache($this->getCacheDir().'/'.$class.'.php', $this->debug);

        $container = $this->buildContainer();
        $container->compile();
        $this->dumpContainer($cache, $container, $class, $this->getContainerBaseClass());
    }
}
