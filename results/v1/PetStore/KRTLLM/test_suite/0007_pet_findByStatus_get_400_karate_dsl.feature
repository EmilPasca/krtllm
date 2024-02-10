Feature: API Security Testing Scenario
Background:
  * URL path: /pet/findByStatus
  * Request headers: None
  * Request body (if any): None
Scenario: 1-CheckForSQLInjectionVulnerability
  Given url /pet/findByStatus
  And request headers are empty
  When method is GET
  Then status code should be 200
  And match response body with the following schema (if any): None
Scenario: 2-CheckForBrokenAuthenticationVulnerability
  Given url /pet/findByStatus
  And request headers are empty
  When method is GET
  Then status code should be 401
  And match response body with the following schema (if any): None
Scenario: 3-CheckForCSRFVulnerability
  Given url /pet/findByStatus
  And request headers are empty
  When method is POST
  Then status code should be 405
  And match response body with the following schema (if any): None
Scenario: 4-CheckForInsecureDirectObjectReferenceVulnerability
  Given url /pet/findByStatus
  And request headers are empty
  When method is GET and query param status = "available"
  Then status code should be 200
  And match response body with the following schema (if any): None
Scenario: 5-CheckForCrossSiteScriptingVulnerability
  Given url /pet/findByStatus
  And request headers are empty
  When method is GET and query param status = "available"
  Then status code should be 200
  And match response body with the following schema (if any): None