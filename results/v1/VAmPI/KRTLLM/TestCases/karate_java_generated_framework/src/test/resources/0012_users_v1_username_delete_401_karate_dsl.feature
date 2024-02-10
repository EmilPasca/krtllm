Feature: API Security Testing Scenario

Scenario: API_Security_Test_DeleteUser-VulnerabilityChecks
    Given url 'http://localhost:5000/users/v1/users/v1/{username}'
    When method DELETE
    Then status 200
    And match body { "status": "fail", "message": "Only Admins may delete users!" }