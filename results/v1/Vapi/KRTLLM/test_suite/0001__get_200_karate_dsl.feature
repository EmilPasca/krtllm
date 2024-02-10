Feature: API Security Testing Scenario
Background: 
    * URL path: /api/v1/users
    * Request headers: Authorization: Bearer <access_token>
    * Request body (if any): { "username": "testuser", "password": "testpass" }
Scenario: API-Security-Test01-CreateUser
    Given url /api/v1/users
    And request headers Authorization: Bearer <access_token>
    When method POST
    Then status 201
    
    And match body { "username": "testuser", "password": "testpass" }