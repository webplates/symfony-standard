<?php

namespace spec\AppBundle\Entity;

use PhpSpec\ObjectBehavior;

class UserSpec extends ObjectBehavior
{
    function it_is_initializable()
    {
        $this->shouldHaveType('AppBundle\Entity\User');
    }

    function it_has_a_null_id_by_default()
    {
        $this->getId()->shouldReturn(null);
    }

    function it_has_a_username()
    {
        $this->getUsername()->shouldReturn(null);

        $this->setUsername('admin');

        $this->getUsername()->shouldReturn('admin');
    }

    function it_has_a_name()
    {
        $this->getName()->shouldReturn(null);

        $this->setName('Admin');

        $this->getName()->shouldReturn('Admin');
    }
}
