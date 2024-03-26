```karate
// Define the OpenAPI specification for the API endpoint
const openApiSpec = {
    "path": "/",
    "method": "GET",
    "responses": {
        "200": {
            "description": "Home - Help",
            "content": {
                "application/json": {
                    "schema": {
                        "type": "object",
                        "properties": {
                            "message": {
                                "type": "string",
                                "example": "VAmPI the Vulnerable API"
                            },
                            "help": {
                                "type": "string",
                                "example": "VAmPI is a vulnerable on purpose API. It was created in order to evaluate the efficiency of third party tools in identifying vulnerabilities in APIs but it can also be used in learning/teaching purposes."
                            },
                            "vulnerable": {
                                "type": "number",
                                "example": 1
                            }
                        }}, ",
```karate [Feature]: Test API for BOLA and Authentication Vulnerabilities
    Background: url 'http://localhost:5000'
    Scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Flaws
         Given path '/api/user/profile'
         And header Authorization = 'Bearer <dynamic_token>>'
         When method GET
         Then status 200 or 403
         And match response.contains('Profile data'),
         And assert !response.contains('Access denied') unless token is 'invalid_token',
         Given header Authorization = 'Bearer <other_user_token>>'
         When method GET
         Then status 403
         And match response.contains('Unauthorized access.'),
         Given header Authorization = 'Bearer <valid_token>>'
         When method GET
         Then status 200
         And match response contains '{ "user": "testUser", "role": "admin" }',
         Given header Authorization = 'Bearer <guest_token>>'
         When method GET
         Then status 403
         And match response.contains('Access not allowed.'),
         Given header Authorization = 'Bearer <temporary_token>>'
         When method GET
         Then status 500
         And match response contains 'Invalid token.',
         Given header Authorization = 'Bearer <dynamic_token>>'
         When method GET
         Then status 200 or 403
         And assert response.contains('Profile data') && !response.contains('Access denied'),
```karate [Feature]: Test API for BOLA and Authentication Vulnerabilities
    Background: url 'http://localhost:5000'
    Scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Flaws
         Given path '/user/profile'
         And header Authorization = 'Bearer <dynamic_token>>'
         When method GET
         Then status 200 or 403
         And match response.contains('Profile data'),
         And assert !response.contains('Access denied') unless token is 'invalid_token',
         Given header Authorization = 'Bearer <other_user_token>>'
         When method GET
         Then status 403
         And match response.contains('Unauthorized access.'),
         Given header Authorization = 'Bearer <valid_token>>'
         When method GET
         Then status 200
         And match response contains '{ "user": "testUser", "role": "admin" }',
         Given header Authorization = 'Bearer <guest_token>>'
         When method GET
         Then status 403
         And match response.contains('Access not allowed.'),
         Given header Authorization = 'Bearer <temporary_token>>'
         When method GET
         Then status 500
         And match response contains 'Invalid token.',
         Given header Authorization = 'Bearer <dynamic_token>>'
         When method GET
         Then status 200 or 403
         And assert response.contains('Profile data') && !response.contains('Access denied'),
```karate [Feature]: Test API for BOLA and Authentication Vulnerabilities
    Background: url 'http