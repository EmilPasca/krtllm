Feature: API Security Testing Scenario

Background:
  * URL path: /users/v1/{username}
  * Request headers: {headers}
  * Request body (if any): {}

Scenario: [ScenarioID]-[Scenario Name]
  Given url /users/v1/{username}
  And request headers {headers}
  When method DELETE
  Then status 404
    And match responseBody {status: "fail", message: "User not found!"}