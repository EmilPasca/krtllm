Feature: API Security Testing Scenario
Background:
  * URL path: /other/thai/stats
  * Request headers: None
Scenario: 1-API_Security_Testing
  Given url '/other/thai/stats'
  And request body {}
  When method GET
  Then status 200