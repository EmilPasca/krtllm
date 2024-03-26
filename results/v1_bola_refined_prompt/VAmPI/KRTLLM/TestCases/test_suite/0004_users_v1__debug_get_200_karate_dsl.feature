feature: Test API for BOLA and Authentication Vulnerabilities
    background: url 'http://localhost:5000'
    scenario: "Test the `/users/{userId}/profile` endpoint for BOLA and authentication issues"
        given path '/users/{userId}/profile'
        when method get
        then status 200 or status 403 or status 401
        and match response contains 'Access denied or token is invalid.', unless response.contains('User profile data'),
        and assert !response.contains('admin') && response.contains('user'),
        when method get with header Authorization = 'Bearer <token>'
        then status 200 or status 403 or status 401
        and match response contains 'User profile data', unless response.contains('Admin panel access'),
        and assert !response.contains('admin') && response.contains('user'),
        when method get with header Authorization = 'Bearer <token_of_other_user>'
        then status 403 or status 401
        and match response contains 'Access denied or token is invalid.', unless response.contains('User profile data')
    scenario: "Ensure the `/auth/validateToken` endpoint correctly handles authentication tokens"
        given path '/auth/validateToken'
        when method post with request { token: '<token>' }
        then status 200 or status 403 or status 401
        and match response contains 'Token is valid.', unless response.contains('Invalid token'),
        when method post with request { token: '<expired_token>' }
        then status 401 or status 403
        and match response contains 'Token is expired or invalid.', unless response.contains('Token is valid.'),
    scenario: "Test the `/admin/_dashboard` endpoint for unauthorized access, ensuring proper authorization checks"
        given path '/admin/_dashboard'
        when method get with header Authorize = 'Bearer <regular_user_token>'
        then status 403 or status 401
        and match response contains 'Access denied. Admin rights required.', unless response.contains('Admin Dashboard'),
        when method get with header Authorize = 'Bearer <admin_user_token>'
        then status 200 or status 403 or status 401
        and match response contains 'Admin Dashboard', unless response.contains('Access denied.'),
    scenario: "Ensure the `/secure/_endpoint` does not allow access with an admin token from another system, testing for BOLA vulnerabilities"
        given path '/secure/_endpoint'
        when method get with header Authorize = 'Bearer <admin_token_from_other_system>'
        then status 403 or status 401
        and match response contains 'Token is not valid for this system.', unless response.contains('Secure Endpoint Access'),
    scenario: "Test the `/user/_settings` endpoint with a dynamically generated user ID and token, ensuring the application correctly handles BOLA and authentication"
        given path '/user/{userId}_settings'
        when method get with header Authorize = 'Bearer <dynamically_generated_token>'
        then status 200 or status 403 or status 401
        and match response contains 'User settings', unless response.contains('Admin panel access'),
        and assert !response.contains('admin') && response.contains('user'),
    scenario: "Ensure the `/secure/_endpoint` is properly secured against unauthorized access, testing with both regular and admin users"
        given path '/secure/_endpoint'
        when method get with header Authorize = 'Bearer <regular_user_token>'
        then status 403 or status 401
        and match response contains 'Access denied. Admin rights required.', unless response.contains('Secure Endpoint Access'),
        when method get with header Authorize = 'Bearer <admin_user_token>'
        then status 200 or status 403 or status 401
        and match response contains 'Secure Endpoint Access', unless response.contains('Access denied.'),
    scenario: "Test the `/secure/_endpoint` for robust token validation, including cases with invalid or expired tokens"
        given path '/secure/_endpoint'
        when method get with header Authorize = 'Bearer <invalid_token>'
        then status 401 or status 403