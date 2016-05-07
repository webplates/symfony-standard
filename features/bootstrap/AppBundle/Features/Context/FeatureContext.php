<?php

namespace AppBundle\Features\Context;

use AppBundle\Entity\User;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Symfony2Extension\Context\KernelAwareContext;
use Behat\Symfony2Extension\Context\KernelDictionary;

final class FeatureContext extends MinkContext implements SnippetAcceptingContext, KernelAwareContext
{
    use KernelDictionary;

    /**
     * @Given there is a user called :name with the username :username
     */
    public function thereIsAUserCalledWithTheUsername($name, $username)
    {
        $user = new User();

        $user->setName($name);
        $user->setUsername($username);

        $em = $this->getContainer()->get('doctrine')->getManager();

        $em->persist($user);
        $em->flush();
    }
}
