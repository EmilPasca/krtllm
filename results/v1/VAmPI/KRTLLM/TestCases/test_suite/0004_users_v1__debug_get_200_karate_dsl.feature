Feature: API Security Testing Scenario

Background:
  * URL path: /users/v1/_debug
  * Request headers: { "Content-Type": "application/json" }

Scenario: [ScenarioID]-[Scenario Name]
  Given url /users/v1/_debug
  And request body {} (No body required for this GET request)
  When method GET
  Then status 200

  And match response body { "users": [] }
    * Validate the response has no users in the array.