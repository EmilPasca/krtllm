Feature: API Security Testing Scenario
Background: 
    * url: /users/v1/login
    * request headers: { "Content-Type": "application/json" }
Scenario: login_api_security_test
    Given url: /users/v1/login
    And request body: {"username":"John.Doe", "password":"password123"}
    When method: POST
    Then status: 400
         * match response body: { "status": "fail", "message": "Password is not correct for the given username." }