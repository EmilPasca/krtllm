Feature: API Security Testing Scenario
    Background:
        * url: /pet
        * method: POST
        * headers: {Content-Type: application/json}
    Scenario: 1-API_Security_Testing
         Given url /pet
         And request body: {"name": "doggie", "photoUrls": ["https://example.com/photo.png"], "tags": [{"id": 25, "name": "cute"}], "status": "available"}
         When method POST
         Then status: 405
    Scenario: 2-API_Security_Testing_Without_Body
         Given url /pet
         And headers {Content-Type: application/json}
         When method POST
         Then status: 405
    Scenario: 3-CSRF_Vulnerability
         Given url /login
         And request body: {"username": "admin", "password": "123"}
         And headers {Content-Type: application/json}
         When method POST
         Then status: 405
    Scenario: 4-SQL_Injection_Vulnerability
         Given url /users?name=1 or '1'='1
         And request body: {}
         And headers {Content-Type: application/json}
         When method GET
         Then status: 405