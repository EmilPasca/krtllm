Feature: API Security Testing Scenario
Background:
  * URL path: /users/v1/register
  * Request headers: None
Scenario: 1-InvalidRequest
  Given url /users/v1/register
  And request body: { "username": "John.Doe", "password": "password123", "email": "user@tempmail.com" }
  When method POST
  Then status: 400
  And match response body: Invalid Request