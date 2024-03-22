feature: Test API for Security Vulnerabilities
    background: url 'http://api.example.com/users/v1/login'
    scenario: 001-Test API for SQL Injection and Broken Authentication
        Given method post
        And request { username: 'admin', password: 'admin' }
        When status 200 or status 400
        Then match response contains 'Login successful.' if status 200 else 'Invalid credentials.',
    scenario: 002-Test API for CSRF Vulnerabilities
        Given method post
        And header Authorization = 'Bearer <token>'
        When status 200 or status 400
        Then match response contains 'CSRF token is invalid.' if status 400 else 'Request successful.',
    scenario: 003-Test API for Unauthorized Access
        Given method get
        And header Authorization = 'Bearer <token_of_another_user>'
        When status 403 or status 404
        Then match response contains 'Access not allowed.' if status 403 else 'Resource not found.',
    scenario: 004-Test API for Sensitive Data Exposure through Caching
        Given method get
        And header Cache-Control = 'no-store'
        When status 200 or status 400
        Then match response.contains('Data retrieved successfully.') and !response.contains('sensitive'),
    scenario: 005-Test API for Access Control Restriction
        Given method get
        And param userId = 'userA'
        And header Authorization = 'Bearer <token_of_userB>'
        When status 403 or status 404
        Then match response contains 'Access not allowed.' if status 403 else 'Resource not found.',
    scenario: 006-Test API for Insecure Direct Object References
        Given method get
        And param docId = 'doc123'
        When status 403 or status 404
        Then match response contains 'Access to the document is unauthorized.' if status 403 else 'Document not found.',
    scenario: 007-Test API for Insecure Redirection
        Given method get
        And header Authorization = 'Bearer <token>'
        When status 302 or status 400
        Then match header Location == 'http://api.example.com/user/dashboard',
    scenario: 008-Test API for Insecure Redirection with User ID in URL
        Given method get
        And param userId = 'user5'
        When status 302 or status 400
        Then match header Location == 'http://api.example.com/user/profile/' + userId",
    scenario: 009-Test API for Insecure Redirection through Cookie
        Given method get
        And header Cookie = 'sessionId=123456'
        When status 302 or status 400
        Then match header Location == 'http://api.example.com/user/dashboard',
    scenario: 010-Test API for Unauthorized Data Access through BOLA
        Given method get
        And param userId = 'user6'
        And header Authorization = 'Bearer <token_of_user7>'
        When status 403 or status 404
        Then match response contains 'Access to the user data is unauthorized.' if status 403 else 'User not found.',
    scenario: 011-Test API for Insecure Direct Object References with File Paths
        Given method get
        And param filePath = 'documents/file.pdf'
        When status 403 or status 404
        Then match response contains 'Access to the file is unauthorized.' if status 403 else 'File not found.',
    scenario: 012-Test API for Insecure Redirection via Form Submission
        Given method post
        And request { userId: 'user8', email: 'user8@example.com' }
        And header Authorization = 'Bearer <token>'
        When status 302 or status 400
        Then match header Location == 'http://api.example.com/user/profile/' + userId",
    scenario: 013-Test API for Insecure Redirection through Header Manipulation
        Given method get