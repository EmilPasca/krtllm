feature: 'API Security Testing'
    background: 'http://api.example.com/users/{userId}/permission', { headers: { Authorization: 'Bearer <token>' } }, { request: { role: 'admin' } }, { method: 'POST' }
    scenario: 'Test API for Broken Authentication and Unauthorized Access Attempts'
        given url 'http://api.example.com/users/{userId}/permission', { headers: { Authorization: 'Bearer <token>' } }, { request: { role: 'admin' } }, { method: 'POST' }
        when status 403
        then match response contains 'Access denied. Unauthorized action attempted.',
            and assert response.status == 403,
            and assert !response.contains('Internal Server Error'),
            and assert response.headers['X-Frame-Options'] == 'DENY',
            and assert response.headers['X-Content-Type-Options'] == 'nosniff'
    Background: 'http://api.example.com/users/{userId}/permission', { headers: { Authorization: 'Bearer <token>' } }, { request: { role: 'user' } }, { method: 'POST' }
    Scenario: 'Test API for Unauthorized Access Attempts with User Role'
        given url 'http://api.example.com/users/{userId}/permission', { headers: { Authorization: 'Bearer <token>' } }, { request: { role: 'user' } }, { method: 'POST' }
        when status 403
        then match response contains 'Access not allowed with your role.',
            and assert response.status == 403,
            and assert !response.contains('Internal Server Error'),
            and assert response.headers['X-Frame-Options'] == 'DENY',
            and assert response.headers['X-Content-Type-Options'] == 'nosniff'
    Background: 'http://api.example.com/users/{userId}/permission', { headers: { Authorization: 'Bearer <token>' } }, { request: { role: 'admin' } }, { method: 'POST' }
    Scenario: 'Test API for CSRF Token Validation'
        given url 'http://api.example.com/users/{userId}/permission', { headers: { Authorization: 'Bearer <token>' } }, { request: { role: 'admin' } }, { method: 'POST' }
        when status 200
        then match response contains 'CSRF token is valid.',
            and assert response.status == 200,
            and assert !response.contains('Internal Server Error'),
            and assert response.headers['X-Frame-Options'] == 'DENY',
            and assert response.headers['X-Content-Type-Options'] == 'nosniff'
    Background: 'http://api.example.com/users/{userId}/permission', { headers: { Authorization: 'Bearer <token>' } }, { request: { role: 'user' } }, { method: 'POST' }
    Scenario: 'Test API for CSRF Token Validation with User Role'
        given url 'http://api.example.com/users/{userId}/permission', { headers: { Authorization: 'Bearer <token>' } }, { request: { role: 'user' } }, { method: 'POST' }
        when status 200
        then match response contains 'CSRF token is valid.',
            and assert response.status == 200,
            and assert !response.contains('Internal Server Error'),
            and assert response.headers['X-Frame-Options'] == 'DENY',
            and assert response.headers['X-Content-Type-Options'] == 'nosniff' [question]: Write a Karate DSL test case for the following API Spec: {"path": "http://api.example.com/auth/signup", "method": "POST", "parameters": ["username", "password"]}
    scenario: 'Test API for Preventing Username Enumeration during Sign Up'
        given url 'http://api.example.com/auth/signup', { request: { username: 'existingUser', password: 'Password123!' } }, { method: 'POST' }
        when status 409
        then match response contains 'Username already exists.',
            and assert response.status == 409,
            and assert !response.contains('Internal Server