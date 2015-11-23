<?php

use Doctrine\Common\Annotations\AnnotationRegistry;
use Composer\Autoload\ClassLoader;

error_reporting(error_reporting() & ~E_USER_DEPRECATED);

$vendorDir = getenv('COMPOSER_VENDOR_DIR') ?: '/opt/symfony/vendor';

/**
 * @var ClassLoader $loader
 */
$loader = require $vendorDir.'/autoload.php';

AnnotationRegistry::registerLoader(array($loader, 'loadClass'));

return $loader;
