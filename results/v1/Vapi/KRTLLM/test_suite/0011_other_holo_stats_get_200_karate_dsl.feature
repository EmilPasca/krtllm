Feature: API Security Testing Scenario
Background:
  * URL path: /other/holo/stats
  * Request headers: {}
Scenario: api-security-testing-1-sql_injection
  Given url '/other/holo/stats'
  And request body {}
  When method GET
  Then status 200