<?php

use Doctrine\Common\Annotations\AnnotationRegistry;
use Composer\Autoload\ClassLoader;

error_reporting(error_reporting() & ~E_USER_DEPRECATED);

$vendorDir = dirname(__DIR__).'/vendor';

if (getenv('USER') === 'vagrant') {
    $vendorDir = getenv('COMPOSER_VENDOR_DIR') ?: '/opt/symfony/vendor';
}

define('SYMFONY_BASEPATH', dirname($vendorDir));

/**
 * @var ClassLoader $loader
 */
$loader = require SYMFONY_BASEPATH.'/vendor/autoload.php';

AnnotationRegistry::registerLoader(array($loader, 'loadClass'));

return $loader;
