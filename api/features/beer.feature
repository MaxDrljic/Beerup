Feature: Manage beers and their favorites
  In order to manage beers and their favorites
  As a client software developer
  I need to be able to retrieve, create, update and delete them through the API.

  # the "@createSchema" annotation provided by API Platform creates a temporary SQLite database for testing the API
  @createSchema
  Scenario: Create a beer
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/beers" with body:
      """
      {
      "id": 1,
      "name": "Heineken",
      "description": "This beer is designed for PHP developers and architects who want to modernize their skills through better understanding of Persistence and ORM.",
      "abv": "10",
      "ibu": "15",
      "imageUrl": "",
      "favorites": ""
      }
      """
    Then the response status code should be 201
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
      """
      {
      "@context": "/contexts/beer",
      "@id": "/beers/1",
      "@type": "beer",
      "id": 1,
      "name": "Heineken",
      "description": "This beer is designed for PHP developers and architects who want to modernize their skills through better understanding of Persistence and ORM.",
      "abv": "10",
      "ibu": "15",
      "favorites": []
      }
      """

  Scenario: Retrieve the beer list
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/beers"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
      """
      {
      "@context": "/contexts/beer",
      "@id": "/beers",
      "@type": "hydra:Collection",
      "hydra:member": [
      {
      "@id": "/beers/1",
      "@type": "beer",
      "id": 1,
      "name": "Heineken",
      "description": "This beer is designed for PHP developers and architects who want to modernize their skills through better understanding of Persistence and ORM.",
      "abv": "10",
      "ibu": "15",
      "favorites": []
      }
      ],
      "hydra:totalItems": 1
      }
      """

  Scenario: Throw errors when a post is invalid
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/beers" with body:
      """
      {
      "name": "Heineken",
      "description": Hello,
      "abv": "",
      "ibu": 15,
      }
      """
    Then the response status code should be 400
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
      """
      {
      "@context": "/contexts/ConstraintViolationList",
      "@type": "ConstraintViolationList",
      "hydra:name": "An error occurred",
      "hydra:description": "isbn: This value is neither a valid ISBN-10 nor a valid ISBN-13.\ntitle: This value should not be blank.",
      "violations": [
      {
      "propertyPath": "ibu",
      "message": "This value is neither a valid ISBN-10 nor a valid ISBN-13."
      },
      {
      "propertyPath": "abv",
      "message": "This value should not be blank."
      }
      ]
      }
      """

  # The "@dropSchema" annotation must be added on the last scenario of the feature file to drop the temporary SQLite database
  @dropSchema
  Scenario: Add a favorite
    When I add "Content-Type" header equal to "application/ld+json"
    When I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/favorites" with body:
      """
      {
      "author": "Foo Bar",
      "publicationDate": "2016-01-01",
      "beer": "/beers/1",
      "id": 1
      }
      """
    Then the response status code should be 201
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
      """
      {
      "@context": "/contexts/favorite",
      "@id": "/favorites/1",
      "@type": "favorite",
      "id": 1,
      "author": "Foo Bar",
      "publicationDate": "2016-01-01T00:00:00+00:00",
      "beer": "/beers/1"
      }
      """

