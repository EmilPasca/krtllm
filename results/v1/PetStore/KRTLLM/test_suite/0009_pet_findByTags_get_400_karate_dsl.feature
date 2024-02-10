Feature: API Security Testing Scenario
Background:
  * URL path: /pet/findByTags
  * Request headers: None
  * Request body: None
Scenario: 1-CheckSQLInjectionVulnerability
  Given url '/pet/findByTags'
  And request body {}
  When method GET
  Then status 200
  And match response { "message": "Invalid tag value" }

Scenario: 2-BrokenAuthentication
Background:
  * URL path: /pet/createWithArray
  * Request headers: None
  * Request body: {"name":"Dummy", "tags":["a","b"]}
Scenario: 3-CheckCSRFVulnerability
  Given url '/pet/createWithArray'
  And request body { "name": "Dummy", "tags": ["a", "b"] }
  When method POST
  Then status 201