<?php

use Doctrine\Common\Annotations\AnnotationRegistry;
use Composer\Autoload\ClassLoader;

error_reporting(error_reporting() & ~E_USER_DEPRECATED);

// Vendor and var can be stored outside of the base path
// This will be available as an option called "kernel.storage_dir"
$storageDir = getenv('SYMFONY__kernel__storage_dir');

if (empty($storageDir)) {
    $storageDir = dirname(__DIR__);

    putenv('SYMFONY__kernel__storage_dir='.$storageDir);
    $_SERVER['SYMFONY__kernel__storage_dir'] = $storageDir;
    $_ENV['SYMFONY__kernel__storage_dir'] = $storageDir;
}

// Don't rely on this constant
define('KERNEL_STORAGE_DIR', $storageDir);

/**
 * @var ClassLoader $loader
 */
$loader = require KERNEL_STORAGE_DIR.'/vendor/autoload.php';

AnnotationRegistry::registerLoader([$loader, 'loadClass']);

return $loader;
