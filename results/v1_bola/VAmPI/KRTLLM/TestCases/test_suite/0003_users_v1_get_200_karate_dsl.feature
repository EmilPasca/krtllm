feature: Test API for Security Vulnerabilities
    background: url 'http://api.example.com/users/v1'
    scenario: "Test the endpoint for security vulnerabilities including SQL Injection, Broken Authentication, and CSRF"
        Given method get
        Then status 200
        And match response contains 'See basic info about all users',
        And assert !response.contains('error'),
        And assert response does not contain '; DROP TABLE users;'
    scenario: "Ensure the authentication process is secure and resistant to unauthorized access"
        Given header Authorization = 'Bearer <token>'
        When method get
        Then status 200
        And match response contains 'Authenticated successfully',
        And assert !response.contains('Authentication failed'),
    scenario: "Test the endpoint for CSRF vulnerabilities"
        Given header Csrf-Token = '<token>'
        When method post
        Then status 200
        And match response contains 'CSRF token verified',
        And assert !response.contains('Invalid CSRF token'),
    scenario: "Ensure the API handles dynamic query parameters and body data securely, preventing SQL Injection attacks"
        Given param search = 'user'
        When method get
        Then status 200
        And match response contains 'Search results for user',
        And assert !response.contains('; DROP TABLE users;'),
    scenario: "Test the endpoint with an invalid token to ensure secure authentication"
        Given header Authorization = 'Bearer <invalid_token>'
        When method get
        Then status 403
        And match response contains 'Invalid token',
        And assert !response.contains('Authenticated successfully'),
    scenario: "Ensure the API sanitizes and validates input data to prevent SQL Injection attacks"
        Given request { userId: 'user123', action: 'update' }
        When method post
        Then status 200
        And match response contains 'Action performed successfully',
        And assert !response.contains('; DROP TABLE users;'),
    scenario: "Test the endpoint for handling expired JSON Web Tokens (JWT)"
        Given header Authorization = 'Bearer <expired_token>'
        When method get
        Then status 401
        And match response contains 'Token has expired',
        And assert !response.contains('Authenticated successfully'),
    scenario: "Ensure the API validates and sanitizes header values to prevent security breaches"
        Given header Api-Key = '<api_key>'
        When method get
        Then status 200
        And match response contains 'Api key is valid',
        And assert !response.contains('Invalid api key'),
    scenario: "Test the endpoint for handling unauthorized access attempts"
        Given header Authorization = 'Bearer <user_token>'
        When method get '/admin/dashboard'
        Then status 403
        And match response contains 'Access denied',
        And assert !response.contains('Dashboard data'),
    scenario: "Ensure the API validates and sanitizes request body data to prevent SQL Injection attacks"
        Given request { userId: 'user123', action: 'update' }
        When method post
        Then status 200
        And match response contains 'Action performed successfully',
        And assert !response.contains('; DROP TABLE users;'),
    scenario: "Test the endpoint for handling unauthorized access attempts via header manipulation"
        Given header Api-Key = '<api_key>'
        When method get '/admin/dashboard'
        Then status 403
        And match response contains 'Api key is not valid for admin access',
        And assert !response.contains('Dashboard data'),
    scenario: "Ensure the API sanitizes and validates input data to prevent SQL Injection attacks"
        Given request { userId: 'user123', action: 'update' }
        When method post
        Then status 200
        And match response contains 'Action performed successfully',
        And assert !response.contains('; DROP TABLE users;'),
    scenario: "Test the endpoint for handling expired JSON Web Tokens (JWT)"
        Given header Authorization = 'Bearer <expired_token>'
        When method get
        Then status 401
        And match response contains 'Token has expired',
        And assert !response.contains('Authenticated successfully'),
    scenario