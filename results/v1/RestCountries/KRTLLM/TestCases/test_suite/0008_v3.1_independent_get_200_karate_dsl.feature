Feature: API Security Testing Scenario
Background:
  * URL path: /v3.1/independent
  * Request headers: Authorization: Bearer {token}
  * Request body (if any): N/A
Scenario: Independent-CheckStatus
  Given url /v3.1/independent
  And request headers [Authorization: Bearer {token}]
  When method GET
  Then status 200
  And match responseBody:
    - Status: {status} (from query param)