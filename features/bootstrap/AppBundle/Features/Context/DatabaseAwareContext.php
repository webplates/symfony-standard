<?php

namespace AppBundle\Features\Context;

use Behat\Behat\Context\Context;
use Behat\Symfony2Extension\Context\KernelAwareContext;
use Behat\Symfony2Extension\Context\KernelDictionary;
use Doctrine\Common\DataFixtures\Purger\ORMPurger;

final class DatabaseAwareContext implements Context, KernelAwareContext
{
    use KernelDictionary;

    /**
     * @BeforeScenario @dbIsolation
     */
    public function clearData()
    {
        $purger = new ORMPurger($this->getContainer()->get('doctrine')->getManager());
        $purger->purge();
    }
}
