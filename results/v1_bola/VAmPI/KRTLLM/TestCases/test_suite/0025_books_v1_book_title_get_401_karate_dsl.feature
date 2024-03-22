Feature: Secure API Endpoint Against Common Vulnerabilities
    Background: url 'http://api.example.com/books/{book_title}'
    Scenario: 1-SecureBookEndpointAgainstVulnerabilities
         Given method get
         And param book_title = 'bookTitle77'
         When header Authorization = 'Bearer <user_token>'
         Then status 200

         And match response contains '{ "status": "success", "message": "Book data retrieved successfully" }',
         And assert !response.contains('error'),
         And assert response does not contain '; DROP TABLE books;'
    Scenario: 2-TestEndpointForBrokenAuthentication
         Given method get
         When header Authorization = 'Bearer <expired_token>'
         Then status 401

         And match response contains '{ "status": "fail", "message": "Token is expired or invalid" }',
         And assert !response.contains('; DROP TABLE sessions;'),
    Scenario: 3-TestEndpointForCSRF
         Given method post
         When header Cookie = 'sessionId=oldSessionId'
         Then status 200

         And match response contains '{ "status": "success", "message": "Data updated successfully" }',
         And assert !response.contains('; DROP TABLE sessions;'),
    Scenario: 4-TestEndpointForSQLInjection
         Given method post
         When request { title: 'bookTitle' || ' AND 1=1', author: 'authorName' }
         Then status 200 or status 400

         And assert !response.contains('; DROP TABLE books;'),
    Scenario: 5-TestEndpointForAccessControl
         Given method get
         When header Authorization = 'Bearer <user_token>' && param bookId = 'adminBookId'
         Then status 403

         And match response contains '{ "status": "access denied", "message": "User does not have permission to access this book" }',
         And assert !response.contains('; DROP TABLE users;'),
    Scenario: 6-TestEndpointForInsecureDirectObjectReferences
         Given method get
         When param objectId = 'object77' && header Authorization = 'Bearer <user_token>'
         Then status 403

         And match response contains '{ "status": "access denied", "message": "User does not have permission to access this object" }',
         And assert !response.contains('; DROP TABLE objects;'),
    Scenario: 7-TestEndpointForHeaderManipulation
         Given method post
         When header Authorization = 'Bearer <user_token>' && header Custom-Header = 'value'
         Then status 200

         And match response contains '{ "status": "success", "message": "Data posted successfully" }',
         And assert !response.contains('; DROP TABLE headers;'),
    Scenario: 8-TestEndpointForUnauthorizedAccessToFile
         Given method get
         When param filePath = 'file77' && header Authorization = 'Bearer <user_token>'
         Then status 403

         And match response contains '{ "status": "access denied", "message": "User does not have permission to access this file" }',
         And assert !response.contains('; DROP TABLE files;'), [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "/oauth/refresh", "method": "POST", "summary": "Refreshes access and refresh tokens", "parameters": ["client_id", "client_secret"]}