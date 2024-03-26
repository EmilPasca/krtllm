feature: Test API for BOLA and Authentication Vulnerabilities
    background: url 'http://localhost:5000'
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Flaws
        given path '/users/v1'
        when method GET
        then status 200 or status 403
        and match response.contains('User not authorized to access this data.'), response contains 'Access granted.',
        and match response.header['Authorization'] == 'Bearer <token>'
    scenario: [ScenarioID]-Fuzz Test Endpoint for Authentication Flaws
        given path '/auth/v1'
        when method POST
        then status 200 or status 400
        and match response.contains('Authentication successful.'), response contains 'Invalid credentials.',
        and assert !response.contains('status=500'), !response.contains('Internal Server Error')
    scenario: [ScenarioID]-Authorization Check with Dynamic Tokens
        given path '/dashboard/v1'
        when method GET
        then status 403 or status 200
        and match response.header['Authorization'] == 'Bearer <dynamic_token>'
        and assert !response.contains('Access denied.'), response contains 'Dashboard accessed successfully.',
        and assert response.header['Authorization'] != 'Bearer <other_user_token>'
    scenario: [ScenarioID]-Validate Authentication Token on Endpoint Access
        given path '/secure/v1'
        when method GET
        then status 200 or status 403
        and match response.header['Authorization'] == 'Bearer <token>'
        and assert !response.contains('Invalid token.'), response contains 'Access granted with valid token.',
        and assert response.header['Authorization'] != 'Bearer <invalid_token>'
    scenario: [ScenarioID]-Ensure Proper Authorization Checks Across Endpoints
        given path '/admin/v1'
        when method GET
        then status 403 or status 200
        and match response.contains('Access denied due to insufficient permissions.'), response contains 'Admin actions permitted.',
        and assert !response.contains('Unauthorized access detected.'), !response.contains('Internal Server Error')
    scenario: [ScenarioID]-Avoid Hardcoded Endpoint Paths, Use Placeholders Instead
        given path '/api/v1/{endpoint}'
        when method GET
        then status 200 or status 404
        and match response.contains('Endpoint not found.'), response contains 'API accessed successfully.',
        and assert !response.contains('http://localhost:5000'), !response.contains('/api/v1')
    scenario: [ScenarioID]-Test Endpoint with Sensitive Data Handling for Authentication Tokens
        given path '/user/profile/v1'
        when method GET
        then status 200 or status 403
        and match response.header['Authorization'] == 'Bearer <token>'
        and assert !response.contains('token'), response contains 'User profile data',
        and assert response.header['Authorization'] != 'Bearer <other_user_token>'
    scenario: [ScenarioID]-Ensure Endpoint Secure Against Injection Attacks
        given path '/search/v1'
        when method GET
        then status 200 or status 400
        and match response.contains('Search results found.'), response contains 'Invalid search query.',
        and assert !response.contains('status=500'), !response.contains('Internal Server Error')
    scenario: [ScenarioID]-Fuzz Test Endpoint for Unhandled Exceptions
        given path '/errorHandling/v1'
        when method POST
        then status 200 or status 400
        and match response.contains('Request processed successfully.'), response contains 'Invalid request data.',
        and assert !response.contains('status=500'), !response.contains('Internal Server Error')
    scenario: [ScenarioID]-Test Endpoint with Unauthorized Access Attempt
        given path '/restricted/v1'
        when method GET
        then status 403 or status 200
        and match response contains 'Access denied due to insufficient permissions.', response contains 'Access granted.'
    scenario: [ScenarioID]-Ensure