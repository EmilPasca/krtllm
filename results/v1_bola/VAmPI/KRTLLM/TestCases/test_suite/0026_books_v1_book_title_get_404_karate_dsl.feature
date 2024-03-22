Feature: Test API for Security Vulnerabilities
    Background: url 'http://api.example.com/books/v1/{book_title}'
    Scenario: 001-Test API Endpoint for Security Flaws
         Given method get
         And param book_title = 'bookTitle77'
         When status 404
         Then match response contains 'Book not found!',
             assert response.contains('status=fail'),
             assert response.contains('message=Book not found!'),
             assert !response.contains('SQL'),
             assert !response.contains('admin'),
             assert response does not contain '<script>alert(1)</script>'
    Scenario: 002-Test API Endpoint for Broken Authentication
         Given header Authorization = 'Bearer <token>'
         When status 400
         Then match response contains 'Invalid token',
             assert response.contains('status=fail'),
             assert response.contains('message=Invalid token'),
             assert !response.contains('SQL'),
             assert !response.contains('admin'),
             assert response does not contain '<script>alert(1)</script>'
    Scenario: 003-Test API Endpoint for CSRF Vulnerabilities
         Given header Cookie = 'sessionId=oldSessionId'
         When status 400
         Then match response contains 'CSRF token mismatch',
             assert response.contains('status=fail'),
             assert response.contains('message=CSRF token mismatch'),
             assert !response.contains('SQL'),
             assert !response.contains('admin'),
             assert response does not contain '<script>alert(1)</script>'
    Scenario: 004-Test API Endpoint for Unauthorized Access
         Given header Authorization = 'Bearer <user_token>'
         When status 403
         Then match response contains 'Access denied',
             assert response.contains('status=fail'),
             assert response.contains('message=Access denied'),
             assert !response.contains('SQL'),
             assert !response.contains('admin'),
             assert response does not contain '<script>alert(1)</script>'
    Scenario: 005-Test API Endpoint for Sensitive Data Exposure
         Given header Authorization = 'Bearer <user_token>'
         When status 200
         Then match response.contains('data=sensitive'),
             assert !response.contains('SQL'),
             assert !response.contains('admin'),
             assert response does not contain '<script>alert(1)</script>'
    Scenario: 006-Test API Endpoint for Insecure Direct Object References
         Given param objectId = 'objId123'
         When status 403
         Then match response contains 'Access to the object is unauthorized',
             assert response.contains('status=fail'),
             assert response.contains('message=Access to the object is unauthorized'),
             assert !response.contains('SQL'),
             assert !response.contains('admin'),
             assert response does not contain '<script>alert(1)</script>'
    Scenario: 007-Test API Endpoint for Header Manipulation (XSS Prevention)
         Given header Custom-Header = 'value'
         When status 200
         Then match !response.contains('<script>'),
             assert response does not contain '<script>alert(1)</script>'
    Scenario: 008-Test API Endpoint for Unhandled Exceptions (General Security Check)
         Given method post
         And request { data: 'sampleData', userId: 'userId' }
         When status 500
         Then match response contains 'An unexpected error occurred',
             assert response.contains('status=fail'),
             assert response does not contain '<script>alert(1)</script>'
    Scenario: 009-Test API Endpoint for Access Control (Authorisation)
         Given header Authorization = 'Bearer <user_token_not_owning_resource>'
         When status 403
         Then match response contains 'Access not allowed',
             assert response.contains('status=fail'),
             assert response.contains('message=Access not allowed'),
             assert !response.contains('SQL'),
             assert !response.contains('admin'),
             assert response does not contain '<script>alert(1)</script>'
    Scenario: 010-Test API Endpoint for Secure Redirection Handling
         Given method get