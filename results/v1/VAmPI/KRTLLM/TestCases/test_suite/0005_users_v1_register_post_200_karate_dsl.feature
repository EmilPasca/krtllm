Feature: Register User API Security Testing Scenario
    Background:
        * URL path: /users/v1/register
        * Request headers: { "Content-Type": "application/json" }
    Scenario: 1-RegisterUserSuccessfully
         Given url '/users/v1/register'
         And request body '{"username":"John.Doe", "password":"password123", "email":"user@tempmail.com"}'
         When method POST
         Then status 200
    Scenario: 2-RegisterUserFailedAuthentication
         Given url '/users/v1/register'
         And request body '{"username": "", "password":"password123", "email":"user@tempmail.com"}'
         When method POST
         Then status 401