Feature: API Security Testing Scenario

Background:
  * URL path: /other/all
  * Request headers: {}
  * Response status code: 200

Scenario: 1-API_Security_Testing
  Given url '/other/all'
  And request body {}
  When method GET
  Then status 200

  And match response { "data": [] }