feature: Test API for SQL Injection, Broken Authentication and CSRF vulnerabilities
    background: url 'http://api.example.com/security'
    scenario: 1-Test API for Security Vulnerabilities
        given method get
        when url 'http://api.example.com/createdb'
        then status 200
        and match response contains 'Database populated.'
        assert !response.contains('error'), 'Invalid response received.'
    scenario: 2-Test API for Broken Authentication
        given method post
        when url 'http://api.example.com/user/login'
        request { userId: 'admin', password: 'password' }
        then status 200
        and match response contains 'Login successful.',
        assert !response.contains('Invalid credentials'), 'Broken Authentication vulnerability detected.'
    scenario: 3-Test API for CSRF Vulnerabilities
        given method post
        when url 'http://api.example.com/user/csrfToken'
        then status 200
        and match response contains 'CSRF token generated.',
        assert !response.contains('Invalid token'), 'CSRF vulnerability detected.'
    scenario: 4-Test API for Unauthorized Access
        given method get
        when url 'http://api.example.com/admin/dashboard'
        then status 403
        and match response contains 'Access denied.',
        assert !response.contains('Admin Dashboard'), 'Unauthorized access not secured.'
    scenario: 5-Test API for Sensitive Data Exposure through Caching
        given method get
        when url 'http://api.example.com/user/profile'
        then status 200
        and match response contains 'User profile data',
        assert !response.contains('cache-control'), 'Sensitive data exposed through cache headers.'
    scenario: 6-Test API for Insecure Direct Object References
        given method get
        when url 'http://api.example.com/document/private'
        then status 403
        and match response contains 'Access denied to the requested document.',
        assert !response.contains('document content'), 'Insecure direct object reference vulnerability.'
    scenario: 7-Test API for Header Manipulation and Security Assertion
        given method get
        when url 'http://api.example.com/header/securityAssertion'
        headers { Authorization: 'Bearer <token>' }
        then status 200
        and match response contains 'Security assertion passed.',
        assert !response.contains('Invalid token'), 'Header manipulation and security assertion testing successful.'
    scenario: 8-Test API for Access Control Restriction
        given method get
        when url 'http://api.example.com/admin/restricted'
        headers { Authorization: 'Bearer <user_token>' }
        then status 403
        and match response contains 'Access restricted.',
        assert !response.contains('Admin actions'), 'Access control restriction not enforced.'
    scenario: 9-Test API for Unauthorized File Download
        given method get
        when url 'http://api.example.com/file/download'
        then status 403
        and match response contains 'File download unauthorized.',
        assert !response.contains('file content'), 'Unauthorized file download not secured.'
    scenario: 10-Test API for Insecure Directory Listing
        given method get
        when url 'http://api.example.com/directory/'
        then status 403
        and match response contains 'Directory listing is insecure.',
        assert !response.contains('file contents'), 'Insecure directory listing vulnerability.'
    scenario: 11-Test API for Inadequate Logging and Monitoring
        given method post
        when url 'http://api.example.com/event/log'
        request { event: 'user_login', userId: 'user123', timestamp: '2023-05-08T10:00:00Z' }
        then status 200
        and match response contains 'Event logged successfully.',
        assert !response.contains('No logs found'), 'Inadequate logging and monitoring.'
    scenario: 12-Test API for Insecure Redirection
        given method get
        when url 'http://api.example.com/redirect'
        then status 302
        and match header Location ==