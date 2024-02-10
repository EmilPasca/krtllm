Feature: API Security Testing Scenario with Vulnerabilities
Background:
* URL path: /v3.1/alpha/{code}
* Request headers: { "Content-Type": "application/json", "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9" }
* Request body (if any): {}
Scenario: 01-SQL_Injection
    Given url /v3.1/alpha/{code}
    And request headers { "Content-Type": "application/json", "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9" }
    When method GET
    Then status 200
    And match response body { "data": [{}] }
Scenario: 02-Broken_Authentication
    Given url /v3.1/alpha/{code}
    And request headers { "Content-Type": "application/json", "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9" }
    When method GET
    Then status 200
    And match response body { "data": [{}] }
Scenario: 03-CSRF
    Given url /v3.1/alpha/{code}
    And request headers { "Content-Type": "application/json", "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9" }
    When method GET
    Then status 200
    And match response body { "data": [{}] }
Scenario: 04-Cross_Site_Scripting
    Given url /v3.1/alpha/{code}
    And request headers { "Content-Type": "application/json", "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9" }
    When method GET
    Then status 200
    And match response body { "data": [{}] }