Feature: API Security Testing Scenario

Scenario: _debug Endpoint check
  Given url 'http://localhost:5000/users/v1/_debug'
  When method GET
  Then status 200
  And match response contains { "users": [] }
