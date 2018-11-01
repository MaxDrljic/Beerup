<?php

use App\Entity\User;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;
use Behatch\Context\RestContext;

class FeatureContext implements Context, SnippetAcceptingContext
{
    // ...
    // Must be after createDatabase() and dropDatabase() functions (the order matters)

    /**
     * @BeforeScenario
     * @login
     *
     * @see https://symfony.com/doc/current/security/entity_provider.html#creating-your-first-user
     */
    public function login(BeforeScenarioScope $scope)
    {
        $user = new User();
        $user->setUsername('admin');
        $user->setPassword('ATestPassword');
        $user->setEmail('test@test.com');

        $this->manager->persist($user);
        $this->manager->flush();

        $token = $this->jwtManager->create($user);

        $this->restContext = $scope->getEnvironment()->getContext(RestContext::class);
        $this->restContext->iAddHeaderEqualTo('Authorization', "Bearer $token");
    }

    /**
     * @AfterScenario
     * @logout
     */
    public function logout() {
        $this->restContext->iAddHeaderEqualTo('Authorization', '');
    }
}

