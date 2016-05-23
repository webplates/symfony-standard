<?php

namespace AppBundle\Controller;

use AppBundle\Entity\User;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class DefaultController extends Controller
{
    /**
     * @Route("/", name="homepage")
     * @Template()
     */
    public function indexAction(Request $request)
    {
        return [
            'base_dir' => realpath($this->container->getParameter('kernel.root_dir').'/..'),
        ];
    }

    /**
     * @ParamConverter("user", options={"mapping": {"user": "username"}})
     * @Route("/hello/{user}", name="hello", defaults={"user" = "admin"})
     * @Template()
     */
    public function helloAction(User $user)
    {
        return compact('user');
    }
}
