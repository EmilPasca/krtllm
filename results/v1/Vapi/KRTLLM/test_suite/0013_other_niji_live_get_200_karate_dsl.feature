Feature: API Security Testing Scenario
Background:
  * URL path: /other/niji/live
  * Request headers: {}
Scenario: SCENARIO1-API_Security_Testing
  Given url /other/niji/live
  And request body {}
  When method GET
  Then status 200