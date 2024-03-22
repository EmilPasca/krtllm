Feature: Test API for Security Vulnerabilities
    Background: url 'http://api.example.com/users/v1/_debug'
    Scenario: 001-Test API for SQL Injection and Broken Authentication
         Given method GET
         Then status 200
         And match response contains 'Users details fetched successfully.',
         And assert !response.contains('error'),
         Assert !response.contains('; DROP TABLE users;'),
         Assert response does not contain 'admin' unless user is an admin,
         Given header Authorization = 'Bearer <token>'
         When method GET
         Then status 200
         And match response contains 'Access granted.',
         And assert !response.contains('Invalid token'),
         Assert !response.contains('; DROP TABLE sessions;'),
    Scenario: 002-Test API for CSRF Vulnerabilities
         Given header Cookie = 'sessionId=oldSessionId'
         When method POST http://api.example.com/users/v1/_debug/update
         Then status 403
         And match response contains 'CSRF token is invalid or expired.',
         Given header Cookie = 'sessionId=newSessionId'
         When method POST http://api.example.com/users/v1/_debug/update
         Then status 200
         And match response contains 'User updated successfully.',
    Scenario: 003-Test API for Unauthorized Access and Sensitive Data Exposure
         Given header Authorization = 'Bearer <user_token>'
         When method GET http://api.example.com/admin/panel/_debug
         Then status 403
         And match response contains 'Access denied. Admin rights required.',
    Scenario: 004-Test API for Insecure Direct Object References Vulnerabilities
         Given param userId = 'user123'
         When method GET http://api.example.com/files/_debug/download
         Then status 403
         And match response contains 'Access denied to the requested file.',
    Scenario: 005-Test API for Header Manipulation and Sensitive Data Exposure
         Given header Authorization = 'Bearer <user_token>'
         When method GET http://api.example.com/profile/_debug
         Then status 200
         And match response contains 'User profile data',
         Assert !response.headers['Authorization'],
    Scenario: 006-Test API for Insecure Directory Listing Vulnerabilities
         Given method GET http://api.example.com/_debug/
         Then status 403
         And match response contains 'Access denied due to insecure directory listing.',
    Scenario: 007-Test API for Unhandled Exceptions and Sensitive Data Exposure
         When method POST http://api.example.com/_debug/handleException
         Then status 500
         And match response contains 'An unexpected error occurred.',
         Assert !response.contains('stack trace'),
    Scenario: 008-Test API for Insecure Redirection Vulnerabilities
         Given header Authorization = 'Bearer <user_token>'
         When method GET http://api.example.com/redirect/_debug
         Then status 302
         And match header Location == 'http://api.example.com/user/dashboard',
    Scenario: 009-Test API for Insecure Redirection with Unauthorized Access
         Given header Authorization = 'Bearer <user_token>'
         When method GET http://api.example.com/admin/redirect/_debug
         Then status 403
         And match response contains 'Access denied to the admin panel.',
    Scenario: 010-Test API for Insecure Redirection with Sensitive Data Exposure
         Given header Authorization = 'Bearer <user_token>'
         When method GET http://api.example.com/profile/redirect/_debug
         Then status 302
         And match header Location == 'http://api.example.com/user/dashboard',
         Assert !header Location contains 'admin' or 'settings',
    Scenario: 011-Test API for Insecure Redirection with Unhandled Exceptions
         When method POST http://api.example.com/_debug/handleException
         Then status 500
         And match header Location == 'http://api.example.com/error/handler',