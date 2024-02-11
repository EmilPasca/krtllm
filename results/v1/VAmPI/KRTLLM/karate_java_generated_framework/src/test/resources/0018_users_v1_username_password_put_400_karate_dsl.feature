Feature: username-test_api_security_scenario
Scenario: API_Security_Test_1-SQL_Injection_Attack
    Given url 'http://localhost:5000/users/v1/users/v1/{username}/password'
    And request headers = '{ "Content-Type": "application/json", "Authorization": "Bearer token" }'
    When method PUT
    Then status 200
Scenario: API_Security_Test_2-Broken_Authentication
    Given url 'http://localhost:5000/users/v1/users/v1/{username}/password'
    When method PUT
    Then status 401
Scenario: API_Security_Test_3-CSRF
    Given url 'http://localhost:5000/users/v1/users/v1/{username}/password'
    When method PUT
    Then status 405
Scenario: API_Security_Test_4-Cross_Site_Scripting
    Given url 'http://localhost:5000/users/v1/users/v1/{username}/password'
    When method PUT
    Then status 200