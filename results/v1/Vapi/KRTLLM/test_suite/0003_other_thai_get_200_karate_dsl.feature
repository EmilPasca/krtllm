Feature: API Security Testing Scenario
Background:
  * URL path: /other/thai
  * Request headers: {}
Scenario: SCENARIOID-API_Security_Testing
  Given url '/other/thai'
  And request body {}
  When method GET
  Then status 200
    And match response { "description": "successful operation", "content": {} }