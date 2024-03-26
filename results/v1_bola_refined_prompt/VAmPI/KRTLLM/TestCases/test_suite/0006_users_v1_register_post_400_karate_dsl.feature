feature: Test API for BOLA and Authentication Vulnerabilities
    background: url 'http://localhost:5000'
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Issues
        given path '/users/v1/secure/endpoint'
        when method POST
        then status 200 or 403 or 401
        and match response contains 'Access granted' or 'Access denied',
        when header Authorization = 'Bearer <dynamic_token>>'
        then status 200 or 403 or 401
        and match response contains 'Secure endpoint accessed successfully' or 'Access denied due to insufficient permissions',
        given request { userId: '<user_id>', action: 'update' }
        when header Authorization = 'Bearer <dynamic_token>>'
        then status 200 or 403 or 401
        and match response contains 'Action performed successfully' or 'Access denied due to insufficient permissions',
        given request { userId: '<user_id>', action: 'delete' }
        when header Authorization = 'Bearer <dynamic_token>>'
        then status 200 or 403 or 401
        and match response contains 'Record deleted successfully' or 'Access denied due to insufficient permissions',
        given request { userId: '<user_id>', action: 'read' }
        when header Authorization = 'Bearer <dynamic_token>>'
        then status 200 or 403 or 401
        and match response contains 'Record read successfully' or 'Access denied due to insufficient permissions',
        given request { userId: '<user_id>', action: 'update' }
        when header Authorization = 'Bearer <dynamic_token>>'
        then status 200 or 403 or 401
        and match response contains 'Action performed successfully' or 'Access denied due to insufficient permissions',
        given request { userId: '<user_id>', action: 'delete' }
        when header Authorization = 'Bearer <dynamic_token>>'
        then status 200 or 403 or 401
        and match response contains 'Record deleted successfully' or 'Access denied due to insufficient permissions',
        given request { userId: '<user_id>', action: 'read' }
        when header Authorization = 'Bearer <dynamic_token>>'
        then status 200 or 403 or 401
        and match response contains 'Record read successfully' or 'Access denied due to insufficient permissions',
        given request { userId: '<user_id>', action: 'update' }
        when header Authorization = 'Bearer <dynamic_token>>'
        then status 200 or 403 or 401
        and match response contains 'Action performed successfully' or 'Access denied due to insufficient permissions',
        given request { userId: '<user_id>', action: 'delete' }
        when header Authorization = 'Bearer <dynamic_token>>'
        then status 200 or 403 or 401
        and match response contains 'Record deleted successfully' or 'Access denied due to insufficient permissions',
        given request { userId: '<user_id>', action: 'read' }
        when header Authorization = 'Bearer <dynamic_token>>'
        then status 200 or 403 or 401
        and match response contains 'Record read successfully' or 'Access denied due to insufficient permissions', [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/oauth/refresh", "method": "POST", "summary": "Refreshes the access token with a refresh token and client ID and secret", "parameters": ["refresh_token", "client_id", "client_secret"]}
    background: url 'http://api.example.com'
    scenario: [ScenarioID]-Test API for Refresh Token Abuse
        given path 'oauth/refresh'
        when method POST
        then status 200 or 403 or 400
        and match response contains 'Access token refreshed successfully' or 'Invalid refresh token',
        when request { refresh_token: '<dynamic_refresh_token>', client_id: '<client_id>', client_