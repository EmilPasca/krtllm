Feature: API Security Testing

Background:
  * URL path: "/other/thai/live"
  * Request headers: {}

Scenario: Vulnerability-1 - SQL Injection
  Given url /api/v1/users/sql_injection
  And request body: { "username": "admin", "password": "or '1'='1" }
  When method POST
  Then status: 200
  And match response body: { "message": "Successfully logged in." }

Scenario: Vulnerability-2 - Broken Authentication
  Given url /api/v1/users/broken_authentication
  When method POST
  Then status: 403
  And match response body: { "message": "Invalid credentials" }

Scenario: Vulnerability-3 - CSRF
  Given url /api/v1/users/csrf
  And request headers: {}
  When method POST
  Then status: 200
  And match response body: { "message": "Successfully logged in." }

Scenario: Vulnerability-4 - Insecure Direct Object Reference
  Given url /api/v1/users/insecure_direct_object_reference
  When method GET
  Then status: 200