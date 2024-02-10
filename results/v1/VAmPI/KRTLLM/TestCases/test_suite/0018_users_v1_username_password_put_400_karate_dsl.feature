Feature: API Security Testing Scenario
Background:
  * URL path: /users/v1/{username}/password
  * Request headers: { "Content-Type": "application/json", "Authorization": "Bearer token" }
  * Request body (if any): { "password": "pass4" }
Scenario: API_Security_Test_1-SQL_Injection_Attack
    Given url /users/v1/{username}/password
    And request headers: { "Content-Type": "application/json", "Authorization": "Bearer token" }
    When method PUT
    Then status 200

    And match body (if any):
        - Status: fail
        - Message: SQL Injection Attack Detected
Scenario: API_Security_Test_2-Broken_Authentication
    Given url /users/v1/{username}/password
    When method PUT
    Then status 401

    And match body (if any):
        - Status: fail
        - Message: Unauthorized Access
Scenario: API_Security_Test_3-CSRF
    Given url /users/v1/{username}/password
    When method PUT
    Then status 405

    And match body (if any):
        - Status: fail
        - Message: CSRF Attack Detected
Scenario: API_Security_Test_4-Cross_Site_Scripting
    Given url /users/v1/{username}/password
    When method PUT
    Then status 200

    And match body (if any):
        - Status: fail
        - Message: Cross Site Scripting Attack Detected