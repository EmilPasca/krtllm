feature: 'Test API for Security Vulnerabilities'
    background: 'http://api.example.com/books/v1/{book_title}'
    scenario: 'Attempt to exploit the `/books/v1/{book_title}` endpoint with malicious parameters'
        given url 'http://api.example.com/books/v1/{book_title}'
        when method get
        then status 400
        and match response contains 'Invalid book title',
    scenario: 'Test the authentication system for broken authentication vulnerabilities'
        given header Authorization = 'Bearer <token>'
        when method get
        then status 200
        and match response.contains('Authenticated successfully.'),
    scenario: 'Ensure the API is secure against CSRF attacks'
        given header Cookie = 'sessionId=sess123',
        when method post
        then status 400
        and match response contains 'CSRF token is invalid or expired.',
    scenario: 'Test the endpoint for SQL injection vulnerabilities'
        given param query = ' OR 1=1',
        when method get
        then status 200
        and match !response.contains('error'),
    scenario: 'Ensure the API enforces secure headers'
        given header 'Secure-Header-Value = "secure; httpOnly;"',
        when method post
        then status 400
        and match response contains 'Invalid header value.',
    background: 'http://api.example.com/user/{userId}/profileImage'
    scenario: 'Test the profile image upload feature for inappropriate file upload vulnerabilities'
        given multipart file file = { read: 'path/to/image.jpg', contentType: 'image/jpeg' },
        when method post
        then status 200
        and match response contains 'Image uploaded successfully.',
    scenario: 'Ensure the API rejects access attempts with invalid authentication tokens'
        given header Authorization = 'Bearer <token_not_valid>'
        when method get
        then status 403
        and match response.contains('Invalid token.'),
    background: 'http://api.example.com/user/{userId}/settings'
    scenario: 'Test the settings update endpoint for elevation of privilege through this API'
        given header Authorization = 'Bearer <other_user_token>'
        when method post
        then status 403
        and match response contains 'Unauthorized to update these settings.',
    background: 'http://api.example.com/auth/signup'
    scenario: 'Ensure the sign-up process is robust against automated script attacks'
        given header Authorization = 'Bearer <token_not_valid>'
        when method post
        then status 403
        and match response contains 'Invalid sign-up attempt.',
    background: 'http://api.example.com/user/{userId}/follow'
    scenario: 'Test the `/user/{userId}/follow` endpoint for unauthorized follow actions'
        given header Authorization = 'Bearer <other_user_token>'
        when method post
        then status 403
        and match response contains 'Unauthorized to follow this user.',
    background: 'http://api.example.com/auth/validateToken'
    scenario: 'Ensure the token validation system is secure against replay attacks'
        given header Authorization = 'Bearer <token>'
        when method get
        then status 200
        and match response contains 'Token is valid.',
    background: 'http://api.example.com/user/{userId}/promote'
    scenario: 'Test the `/user/{userId}/promote` endpoint for elevation of privilege through this API'
        given header Authorization = 'Bearer <admin_token>'
        when method post
        then status 200
        and match response contains 'User promoted successfully.',
    background: 'http://api.example.com/user/{userId}/settings'
    scenario: 'Test the settings update endpoint for insecure direct object reference vulnerabilities'
        given header Authorization = 'Bearer <user_token>'
        when method post
        then status 403
        and match response contains 'Access not allowed.',
    background: 'http://api.example.com/auth/validateToken'
    scenario: 'Ensure the token validation system is secure against theft of tokens'
        given header Authorization = '