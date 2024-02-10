Feature: Pet Store API - Security Testing Scenario
  Background:
    * URL path: /pet/findByStatus
    * Request headers: Authorization: Bearer token, Content-Type: application/json

  Scenario: Check SQL injection vulnerability in the endpoint
    Given url '/pet/findByStatus'
    And request body {}
    When method POST
    Then status 200
    And match response { "name": "doggie", "photoUrls": ["https://example.com/photo.png"], "status": "available" }

Feature: Pet Store API - Security Testing Scenario
  Background:
    * URL path: /pet/findByStatus
    * Request headers: Authorization: Bearer token, Content-Type: application/json

Scenario: Check Broken Authentication vulnerability in the endpoint
    Given url '/pet/findByStatus'
    And request body {}
    When method POST
    Then status 200
    And match response { "name": "doggie", "photoUrls": ["https://example.com/photo.png"], "status": "available" }

Feature: Pet Store API - Security Testing Scenario
  Background:
    * URL path: /pet/findByStatus
    * Request headers: Authorization: Bearer token, Content-Type: application/json

Scenario: Check CSRF vulnerability in the endpoint
    Given url '/pet/findByStatus'
    And request body {}
    When method POST
    Then status 200
    And match response { "name": "doggie", "photoUrls": ["https://example.com/photo.png"], "status": "available" }

Feature: Pet Store API - Security Testing Scenario
  Background:
    * URL path: /pet/findByStatus
    * Request headers: Authorization: Bearer token, Content-Type: application/json

Scenario: Check Insecure Direct Object Reference vulnerability in the endpoint
    Given url '/pet/findByStatus'
    And request body {}
    When method POST
    Then status 200
    And match response { "name": "doggie", "photoUrls": ["https://example.com/photo.png"], "status": "available" }