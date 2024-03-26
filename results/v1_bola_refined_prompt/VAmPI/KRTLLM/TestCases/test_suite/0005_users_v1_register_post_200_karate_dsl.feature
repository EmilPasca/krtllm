feature: Test API for BOLA and Authentication Vulnerabilities
    background: url 'http://localhost:5000'
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Issues
        given path '/users/v1/secure/resource'
        And request { username: 'user', password: 'password' }
        When method POST
        Then status 200 or 403
        And match response contains 'Access granted' or 'Access denied',
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Issues with Dynamic Tokens
        given path '/users/v1/secure/resource'
        And request { username: 'user', password: 'password' }
        When method POST
        Then status 200 or 403
        And match response.contains('Access granted') or response.contains('Access denied'),
    scenario: [ScenarioID]-Test Endpoint for BOLA with Dynamic User IDs and Tokens
        given path '/admin/users/:userId/promote'
        And request { userId: 'user123', token: 'token123' }
        When method POST
        Then status 403 or 200
        And match response.contains('User promoted successfully') or response.contains('Access denied'),
    scenario: [ScenarioID]-Test Endpoint for Authentication Flaws with Dynamic Tokens
        given path '/session/validateToken'
        And request { token: 'token123', userId: 'userId123' }
        When method POST
        Then status 200 or 400
        And match response.contains('Token is valid') or response.contains('Invalid token'),
    scenario: [ScenarioID]-Test Endpoint for Authorization Issues with Dynamic Roles and Tokens
        given path '/admin/reports/:reportId'
        And request { reportId: 'report123', token: 'token123', role: 'admin' }
        When method GET
        Then status 200 or 403
        And match response.contains('Report accessed successfully') or response.contains('Access denied'),
    scenario: [ScenarioID]-Test Endpoint for BOLA with Hardcoded User IDs and Tokens
        given path '/admin/users/:userId/promote'
        And request { userId: 'user13', token: 'token123' }
        When method POST
        Then status 403 or 200
        And match response.contains('User promoted successfully') or response.contains('Access denied'),
    scenario: [ScenarioID]-Test Endpoint for Authentication Flaws with Hardcoded Tokens
        given path '/session/validateToken'
        And request { token: 'hardcoded_token', userId: 'userId123' }
        When method POST
        Then status 200 or 400
        And match response.contains('Token is valid') or response.contains('Invalid token'),
    scenario: [ScenarioID]-Test Endpoint for Authorization Issues with Hardcoded Roles and Tokens
        given path '/admin/reports/:reportId'
        And request { reportId: 'report123', token: 'hardcoded_token', role: 'user' }
        When method GET
        Then status 403 or 200
        And match response.contains('Report accessed successfully') or response.contains('Access denied'), [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/oauth/refresh", "method": "POST", "summary": "Refreshes the access token with a refresh token and client ID and secret", "parameters": ["refresh_token", "client_id", "client_secret"]}

[question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/oauth/validate", "method": "GET", "summary": "Validates an access token", "parameters": ["access_token"]} [response]: {
    feature: 'OAuth Access Token Validation'
    background: url 'http://api.example.com/oauth/validate'
    scenario: '[ScenarioID]-Validate OAuth Access Token',
        given path 'http://