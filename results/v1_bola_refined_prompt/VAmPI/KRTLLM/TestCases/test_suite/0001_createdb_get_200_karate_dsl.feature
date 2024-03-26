feature: Test API for BOLA and Authentication Vulnerabilities
    background: url 'http://localhost:5000'
    scenario: 1-Test Endpoint for BOLA and Auth Flaws
        given path '/createdb'
        when method get
        then status 200 or status 403
        and match response contains 'Database populated.' if status == 200 else 'Access denied.',
    scenario: 2-Fuzz Testing for Authentication Flaws
        given path '/login'
        when method post
        then status 200 or status 400
        and match response contains 'Login successful.' if status == 200 else 'Invalid credentials.',
    scenario: 3-Authorization Check with Dynamic Token Handling
        given header Authorization = 'Bearer <dynamic token>'
        when method get '/dashboard'
        then status 200 or status 403
        and match response contains 'Dashboard accessed successfully.' if status == 200 else 'Access denied.',
    scenario: 4-Testing Endpoint with Hardcoded Token for Authorization Issues
        given header Api-Key = 'hardcoded_token'
        when method get '/restricted'
        then status 200 or status 403
        and match response contains 'Access granted.' if status == 200 else 'Invalid api key.',
    scenario: 5-Fuzz Testing for BOLA on User Profile Endpoint
        given path '/user/profile'
        when method get
        then status 403 or status 404
        and match response contains 'Profile not found.' if status == 404 else 'Access denied.',
    scenario: 6-Testing with Valid User ID but Invalid Role on Profile Endpoint to Ensure Proper Authorization Checks
        given param userId = 'validUserId'
        when method get '/user/profile'
        then status 403 or status 404
        and match response contains 'User does not have the required role.' if status == 403 else 'Profile not found.',
    scenario: 7-Fuzz Testing for BOLA on File Upload Endpoint to Ensure Secure File Handling
        given path '/file/upload'
        when method post
        then status 200 or status 400
        and match response contains 'File uploaded successfully.' if status == 200 else 'Invalid file format.',
    scenario: 8-Testing with Large File Sizes on Upload Endpoint to Ensure System Handles Files Within Limits
        given multipart file file = read('classpath:helpers/largeFile.jpg')
        when method post '/file/upload'
        then status 200 or status 413
        and match response contains 'File uploaded successfully.' if status == 200 else 'File size exceeds the allowable limit.',
    scenario: 9-Testing Endpoint for BOLA on User Role Assignment to Ensure Proper Authorization Controls
        given path '/user/role/assign'
        when method post
        then status 403 or status 200
        and match response contains 'Role assigned successfully.' if status == 200 else 'User does not have the required permissions.',
    scenario: 10-Fuzz Testing for BOLA on User Role Update Endpoint to Ensure Secure Role Handling
        given path '/user/role/update'
        when method post
        then status 403 or status 200
        and match response contains 'Role updated successfully.' if status == 200 else 'User does not have the required permissions.',
    scenario: 11-Testing Endpoint for BOLA on User Role Deletion to Ensure Proper Authorization Controls
        given path '/user/role/delete'
        when method post
        then status 403 or status 200
        and match response contains 'Role deleted successfully.' if status == 200 else 'User does not have the required permissions.',
    scenario: 12-Fuzz Testing for BOLA on User Account Creation Endpoint to Ensure Secure User Handling
        given path '/user/create'
        when method post
        then status 403 or status 200
        and match response contains 'User created successfully.' if status == 200 else 'Account creation unauthorized.',
    scenario: 13-Testing Endpoint for BOLA on User Account Update to