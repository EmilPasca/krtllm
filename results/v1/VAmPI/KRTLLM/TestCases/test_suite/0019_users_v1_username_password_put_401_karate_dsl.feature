Feature: API Security Testing Scenario
Background: 
    * url: /users/v1/{username}/password
    * headers: { "Content-Type": "application/json", "Authorization": "Bearer token" }
Scenario: test_api_security_scenario
    Given url /users/v1/{username}/password
    And request body: { "password": "pass4" }
    When method PUT
    Then status 200
        * match response.body: { "status": "success", "message": "Password updated successfully" }