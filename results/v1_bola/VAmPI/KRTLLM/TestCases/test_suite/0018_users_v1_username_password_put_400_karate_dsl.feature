feature: Test API for Security Vulnerabilities
    background: url 'http://api.example.com/users/{userId}/password'
    scenario: "Update User Password Securely"
        given method post
        and request { password: 'newPass123!' }
        when header Authorization = 'Bearer <token>'
        then status 200

        match response contains 'Password updated successfully.'

    scenario: "Attempt to Exploit Password Update with SQL Injection"
        given request { password: ' OR 1=1' }
        when header Authorization = 'Bearer <token>'
        then status 400

        match response contains 'Invalid request.'
    scenario: "Attempt to Exploit Authentication with CSRF"
        given request { userId: 'user5', token: 'CSRF_TOKEN' }
        when method post
        then status 403

        match response contains 'Unauthorized access attempt detected.'
    scenario: "Ensure Secure Redirection Handling"
        given url 'http://api.example.com/redirect/{url}'
        and request { targetUrl: 'http://malicious.example.com' }
        when header Authorization = 'Bearer <token>'
        then status 400

        match response contains 'Invalid redirection URL.'
    scenario: "Test for Sensitive Data Exposure through Caching"
        given url 'http://api.example.com/cache/{userId}'
        and request { userId: 'user6' }
        when header Authorization = 'Bearer <token>'
        then status 200

        match response does not contain 'userId', 'email'
    scenario: "Ensure Secure Headers are Present"
        given url 'http://api.example.com/headers/{headerName}'
        and request { headerName: 'Secure-Header' }
        when header Authorization = 'Bearer <token>'
        then status 200

        match response headers['X-Frame-Options'] == 'DENY', 'X-Content-Type-Options' == 'nosniff', 'Referrer-Policy' == 'strict-origin-when-cross-origin';
    scenario: "Test for Unauthorized Access to API Endpoints"
        given url 'http://api.example.com/restricted/{userId}'
        when method get
        then status 403

        match response contains 'Access not allowed.'
    scenario: "Ensure Data Transfer is Encrypted"
        given url 'http://api.example.com/transfer/{data}'
        and request { data: 'sensitiveInfo' }
        when header Authorization = 'Bearer <token>'
        then status 200

        match response headers['Content-Encoding'] == 'TLS 1.2';
    scenario: "Test for Sensitive Data Exposure through Caching (Dynamic Fields)"
        given url 'http://api.example.com/cache/{userId}'
        and request { userId: 'user7' }
        when header Authorization = 'Bearer <token>'
        then status 200

        match response does not contain 'userId', 'email';
    scenario: "Ensure API Endpoints are Documented"
        given url 'http://api.example.com/docs/{endpoint}'
        when method get
        then status 200

        match response contains 'API Specification' and 'Endpoint Description';
    scenario: "Test for Unauthorized Data Access through BOLA Vulnerabilities"
        given url 'http://api.example.com/data/{userId}'
        when method get
        then status 403

        match response contains 'Access not authorized.'
    scenario: "Ensure the API Enforces HTTPS Connections"
        given url 'http://api.example.com/'
        when method get
        then status 403

        match response headers['X-Forwarded-Proto'] == 'https';
    scenario: "Test for Sensitive Data Exposure through Caching with Dynamic Fields"
        given url 'http://api.example.com/cache/{userId}'
        and request { userId: 'user8' }
        when header Authorization = 'Bearer <token>'
        then status 200

        match response does not contain 'userId', 'email';
    scenario: "Ensure the API is Robust