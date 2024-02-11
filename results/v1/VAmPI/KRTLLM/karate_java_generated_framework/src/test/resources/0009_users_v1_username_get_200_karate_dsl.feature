Feature: SQLI-001 - SQL Injection Prevention

Scenario: SQLI-001 - SQL Injection Prevention
    Given url 'http://localhost:5000/users/v1/john.doe'
    And request headers '{"Content-Type": "application/json"}'
    When method GET
    Then status 200
    And match response '{ "username": "John.Doe", "email": "user@tempmail.com" }'