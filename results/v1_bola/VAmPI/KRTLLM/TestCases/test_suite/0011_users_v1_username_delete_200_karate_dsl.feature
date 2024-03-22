feature: 'API Security Testing'
    background: 'http://api.example.com/users/{userId}/securityCheck'
    scenario: 'Test API for security vulnerabilities including SQL injection, Broken Authentication, CSRF and others.'
        given url 'http://api.example.com/users/{userId}/securityCheck'
        when method get
        then status 200

        match response contains 'Security check passed.',

        And match header Location == 'http://api.example.com/users/{userId}/secure',

    scenario: 'Test API for SQL Injection vulnerabilities.'
        given url 'http://api.example.com/users/{userId}/securityCheck'
        when method post { userId: ' OR 1=1', apiKey: ' AND 1=1' }
        then status 400

        match response contains 'Invalid parameters.',

    scenario: 'Test API for Broken Authentication vulnerabilities.'
        given url 'http://api.example.com/users/{userId}/secure'
        when method post { apiKey: 'incorrectApiKey', userId: 'user123' }
        then status 403

        match response contains 'Incorrect API key.',

    scenario: 'Test API for CSRF vulnerabilities.'
        given url 'http://api.example.com/users/{userId}/secure'
        when method post { sessionToken: 'session123', userId: 'user456' }
        then status 200

        match response contains 'Secure connection established.',

    scenario: 'Test API for access control vulnerabilities.'
        given url 'http://api.example.com/admin/{userId}/reports/private'
        when method get { userId: 'user7', apiKey: 'adminApiKey' }
        then status 403

        match response contains 'Access denied.',

    scenario: 'Test API for Insecure Direct Object References vulnerabilities.'
        given url 'http://api.example.com/document/{docId}/access'
        when method get { docId: 'doc12', userId: 'user8' }
        then status 403

        match response contains 'Access not allowed.',

    scenario: 'Test API for Sensitive Data Exposure vulnerabilities.'
        given url 'http://api.example.com/users/{userId}/profile'
        when method get { userId: 'user9', apiKey: 'userApiKey' }
        then status 200

        match response contains 'User profile data.',

    scenario: 'Test API for Unauthorized Data Access vulnerabilities.'
        given url 'http://api.example.com/users/{userId}/profile'
        when method get { userId: 'user10', apiKey: 'otherUserApiKey' }
        then status 403

        match response contains 'Access not authorized.',

    scenario: 'Test API for Insecure Redirection vulnerabilities.'
        given url 'http://api.example.com/redirect/{url}'
        when method post { url: 'http://malicious.example.com' }
        then status 400

        match response contains 'Invalid redirection URL.',

    scenario: 'Test API for Header Injection vulnerabilities.'
        given url 'http://api.example.com/headers/{headerId}/inject'
        when method post { headerValue: 'Injected-Header', headerId: 'header123' }
        then status 400

        match response contains 'Invalid header value.',

    scenario: 'Test API for Insecure Directory Listing vulnerabilities.'
        given url 'http://api.example.com/files/'
        when method get { path: '/public/' }
        then status 200

        match response contains 'File listings not allowed.',

    scenario: 'Test API for Hardcoded Credentials vulnerabilities.'
        given url 'http://api.example.com/system/{systemId}/settings'
        when method get { systemId: 'system1', credentials: 'hardcodedPass' }
        then status 200

        match response contains 'System settings data.',

    scenario: 'Test API for Insecure File Upload vulnerabilities.'
        given url 'http://api.example.com/files/{fileId}/upload'
        when method post { filePath: 'path/to/image.png', fileId: 'file123