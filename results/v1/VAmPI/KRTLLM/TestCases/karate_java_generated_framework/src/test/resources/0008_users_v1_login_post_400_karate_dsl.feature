Feature: API Security Testing Scenario login_api_security_test

Scenario: login_api_security_test
    Given url 'http://localhost:5000/users/v1/login'
    And request
    """
    {"username":"John.Doe", "password":"password123"}
    """
    When method POST
    Then status 400