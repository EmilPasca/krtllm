Feature: Capital Search API Security Testing
Background:
  * URL path: /v3.1/capital
  * Request headers: {}

Scenario: ScenarioID-SearchCapitalByName
  Given url '/v3.1/capital'
  And request body {}
  And headers {}
  When method GET
  Then status 200
    And match response { "data": [{"name": "London"}] }