Feature: API Security Testing Scenario
Background:
  * URL path: /other/holo
  * Request headers: None
  * Request body: {}
Scenario: SCENARIOID-API_Security_Testing
  Given url '/other/holo'
  And request body {}
  When method GET
  Then status 200

  And match response { "data": [] }