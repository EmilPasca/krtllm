Feature: username-test_api_security_scenario
Scenario: test_api_security_scenario
    Given url 'http://localhost:5000/users/v1/users/v1/{username}/password'
    And request body: { "password": "pass4" }
    When method PUT
    Then status 200