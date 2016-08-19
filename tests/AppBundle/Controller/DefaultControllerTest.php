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
}
