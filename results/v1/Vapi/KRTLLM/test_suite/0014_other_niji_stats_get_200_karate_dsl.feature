Feature: API Security Testing
  Background:
    * URL path: /other/niji/stats
    * Request headers: None
    * Request body: {}
  Scenario: SCENARIO1-SQL_Injection
    Given url "/other/niji/stats"
    And request body {}
    When method GET
    Then status 200
    And match response body { "data": [{"id": 1, "name": "John"}, {"id": 2, "name": "Jane"}]}
  Scenario: SCENARIO2-Broken_Authentication
    Given url "/other/niji/stats"
    When method GET
    Then status 403
    And match response body { "message": "Unauthorized access." }
  Scenario: SCENARIO3-CSRF
    Given url "/other/niji/stats"
    And request headers {"X-CSRF-Token": "abc123"}
    When method GET
    Then status 400
    And match response body { "message": "Invalid CSRF token." }