<?php

namespace AppBundle\Features\Context;

use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\MinkExtension\Context\RawMinkContext;
use Behat\Symfony2Extension\Context\KernelAwareContext;
use Behat\Symfony2Extension\Context\KernelDictionary;

final class FeatureContext extends RawMinkContext implements SnippetAcceptingContext, KernelAwareContext
{
    use KernelDictionary;
}
