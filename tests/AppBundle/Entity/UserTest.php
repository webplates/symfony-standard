<?php

namespace Tests\AppBundle\Entity;

use AppBundle\Entity\User;

class UserTest extends \PHPUnit_Framework_TestCase
{
    public function testItHasAUsername()
    {
        $user = new User();

        $user->setUsername('fabien');

        $this->assertEquals('fabien', $user->getUsername());
    }

    public function testItHasAName()
    {
        $user = new User();

        $user->setName('Fabien Potencier');

        $this->assertEquals('Fabien Potencier', $user->getName());
    }
}
