<?php

namespace Tests\AppBundle\Controller;

use Liip\FunctionalTestBundle\Test\WebTestCase;

class DefaultControllerTest extends WebTestCase
{
    public function testIndex()
    {
        $client = static::createClient();

        $crawler = $client->request('GET', '/');

        $this->assertStatusCode(200, $client);
        $this->assertContains('Welcome to Symfony', $crawler->filter('#container h1')->text());
    }

    public function testHello()
    {
        $this->loadFixtures([
            'AppBundle\DataFixtures\ORM\LoadUserData',
        ]);

        $client = static::createClient();

        $crawler = $client->request('GET', '/hello/fabien');

        $this->assertStatusCode(200, $client);
        $this->assertContains('Hello, Fabien Potencier!', $crawler->filter('#container h1')->text());
    }
}
