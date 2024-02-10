Feature: API Security Testing Scenario
Background:
  * URL path: /users/v1/{username}
  * Request headers: { "Content-Type": "application/json" }
  * Request body (if any): {}
Scenario: SQLI-001 - SQL Injection Prevention
    Given url "/users/v1/john.doe"
    And request headers {"Content-Type": "application/json"}
    When method GET
    Then status 200
    And match response { "username": "John.Doe", "email": "user@tempmail.com" }