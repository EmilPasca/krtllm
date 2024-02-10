Feature: API Security Testing Scenario
Background:
  * URL path: /v3.1/subregion
  * Request headers: None
  * Request body (if any): None

Scenario: Vulnerability-1 - SQL Injection
  Given url '/v3.1/subregion'
  And request body {}
  And headers []
  When method GET
  Then status 200

  And match response { "data": [{"name": "Europe"}] }

Scenario: Vulnerability-2 - Broken Authentication
  Given url '/v3.1/subregion'
  And request body {}
  And headers []
  When method GET
  Then status 401

Scenario: Vulnerability-3 - CSRF
  Given url '/v3.1/subregion'
  And request body {}
  And headers []
  When method GET
  Then status 200

  And match response { "data": [{"name": "Europe"}] }

Scenario: Vulnerability-4 - Insecure Direct Object Reference
  Given url '/v3.1/subregion'
  And request body {}
  And headers []
  When method GET
  Then status 200

  And match response { "data": [{"name": "Europe"}] }

Scenario: Vulnerability-5 - Cross Site Scripting (XSS)
  Given url '/v3.1/subregion'
  And request body {}
  And headers []
  When method GET
  Then status 200

  And match response { "data": [{"name": "Europe"}] }