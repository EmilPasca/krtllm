Feature: Register User API Security Testing Scenarios
    Scenario: 1-RegisterUserSuccessfully
         Given url 'http://localhost:5000/users/v1/register'
         And request '{"username":"John.Doe", "password":"password123", "email":"user@tempmail.com"}'
         When method POST
         Then status 200
    Scenario: 2-RegisterUserFailedAuthentication
         Given url 'http://localhost:5000/users/v1/register'
         And request '{"username": "", "password":"password123", "email":"user@tempmail.com"}'
         When method POST
         Then status 401