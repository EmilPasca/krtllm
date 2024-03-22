Feature: Test API for Security Vulnerabilities
    Background: url 'http://api.example.com/users/v1/register'
    Scenario: 001-Test API for SQL Injection and Broken Authentication
         Given method post
         And request { username: 'admin OR 1=1', password: 'password', email: 'admin@example.com' }
         When status 400 or status 500
         Then match response contains 'Invalid request' or response contains 'Internal Server Error'
     Scenario: 002-Test API for CSRF and Broken Authentication
         Given method post
         And header Authorization = 'Bearer <token>'
         When status 403 or status 500
         Then match response contains 'Invalid token' or response contains 'Internal Server Error'
     Scenario: 003-Test API for Unauthorized Access
         Given method get
         And header Authorization = 'Bearer <user_token>'
         When url '/admin/dashboard'
         Then status 403
         Then match response contains 'Access denied'
     Scenario: 004-Test API for Sensitive Data Exposure through Caching
         Given method get
         And header Cache-Control = 'no-store, no-cache, must-revalidate, private'"
         When url '/user/profile'
         Then status 200
         Then match response.contains('Profile data:') && !response.contains('age'), asserting that sensitive information like age is not exposed through cache headers.
     Scenario: 005-Test API for Access Control Violation
         Given method get
         And param userId = 'userA'
         When url '/admin/user/reports/{userId}'
         Then status 403 or status 500
         Then match response contains 'Access not allowed' or response contains 'Internal Server Error', ensuring the API enforces strict access control measures.
     Scenario: 006-Test API for Unauthorized Access via Header Manipulation
         Given method get
         And header Authorization = 'Bearer <user_token>'
         When url '/admin/dashboard'
         Then status 403
         Then match response contains 'Access denied through header manipulation', highlighting the importance of secure header handling in API endpoints.
     Scenario: 007-Test API for Insecure Direct Object References
         Given method get
         And param docId = 'doc123'
         When url '/user/document/{docId}'
         Then status 403 or status 500
         Then match response contains 'Access to the document is unauthorized' or response contains 'Internal Server Error', ensuring the API does not allow direct access to documents via their IDs.
     Scenario: 008-Test API for Insecure Direct Object References (Admin Access)
         Given method get
         And header Authorization = 'Bearer <admin_token>'
         When url '/user/document/{docId}'
         Then status 200
         Then match response contains 'Document content' && !response.contains('Access denied'), asserting that admin users can access documents securely without risk of insecure direct object references.
     Scenario: 009-Test API for Insecure Redirection
         Given method get
         And header Authorization = 'Bearer <user_token>'
         When url '/user/profile'
         Then status 200
         Then match header Location == 'http://api.example.com/user/dashboard', ensuring the API does not allow open or relative redirections that could be exploited.
     Scenario: 010-Test API for Insecure Redirection (Admin Access)
         Given method get
         And header Authorization = 'Bearer <admin_token>'
         When url '/user/profile'
         Then status 200
         Then match header Location == 'http://api.example.com/admin/dashboard', asserting that admin users are redirected to a secure administrative dashboard, preventing unauthorized access.
 [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/oauth/refresh", "method": "POST", "parameters": ["client_id", "client_secret"], "summary": "Refreshes the access token with the refresh token and client credentials", "requestBody": {"description": "Refresh token and client credentials for access token renewal",