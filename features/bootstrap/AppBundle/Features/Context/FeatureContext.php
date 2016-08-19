<?php

namespace AppBundle\Features\Context;

use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Symfony2Extension\Context\KernelAwareContext;
use Behat\Symfony2Extension\Context\KernelDictionary;

final class FeatureContext extends MinkContext implements SnippetAcceptingContext, KernelAwareContext
{
    use KernelDictionary;
}
