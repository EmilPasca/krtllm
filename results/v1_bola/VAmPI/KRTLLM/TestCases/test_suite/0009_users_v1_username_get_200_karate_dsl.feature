feature: 'API Security Testing with Karate DSL'
scenario: 'Test API for SQL Injection and Broken Authentication vulnerabilities'
steps: [
    * def username = 'admin';
    * def password = '123456';
    given url 'http://api.example.com/users/{username}/login'
    when method post
    then status 400
    and match response contains 'Incorrect username or password',
    scenario: 'Test API for CSRF vulnerabilities'
    steps: [
        * def sessionToken = 'sessionId123';
        given url 'http://api.example.com/csrf/validateSession'
        when method post
        then status 200
        and match response contains 'Session is valid',
        scenario: 'Test API for Access Control vulnerabilities'
    steps: [
        * def userId = 'user13';
        given url 'http://api.example.com/admin/{userId}/panel'
        when method get
        then status 403
        and match response contains 'Access denied',
        scenario: 'Test API for Sensitive Data Exposure vulnerabilities'
    steps: [
        * def patientId = 'patient1';
        given url 'http://api.example.com/patients/{patientId}/records'
        when method get
        then status 200
        and match response contains 'Patient records',
        scenario: 'Test API for Unauthorized Data Access vulnerabilities'
    steps: [
        * def unauthorizedUserId = 'user14';
        given url 'http://api.example.com/admin/{unauthorizedUserId}/panel'
        when method get
        then status 403
        and match response contains 'Access not authorized',
        scenario: 'Test API for Insecure Direct Object References vulnerabilities'
    steps: [
        * def documentId = 'doc12';
        given url 'http://api.example.com/documents/{documentId}/content'
        when method get
        then status 403
        and match response contains 'Access to the document is unauthorized',
        scenario: 'Test API for Header Manipulation vulnerabilities'
    steps: [
        * def apiKey = 'api_key_123';
        given url 'http://api.example.com/secure/endpoint'
        when method get
        then status 200
        and match header Api-Key == apiKey,
        scenario: 'Test API for Caching Policy vulnerabilities'
    steps: [
        * def cachePolicy = 'no-store';
        given url 'http://api.example.com/cache/policy'
        when method get
        then status 200
        and match header Cache-Control == cachePolicy,
        scenario: 'Test API for Insecure Redirection vulnerabilities'
    steps: [
        * def redirectUrl = 'http://malicious.example.com';
        given url 'http://api.example.com/redirect/{userId}'
        when method get
        then status 400
        and match response contains 'Invalid redirection URL',
        scenario: 'Test API for Unhandled Exceptions vulnerabilities'
    steps: [
        * def unhandledException = new RuntimeException('Unhandled Exception'),
        given url 'http://api.example.com/exception/handler'
        when method post
        then status 500
        and match response contains 'An unexpected error occurred',
        scenario: 'Test API for Insecure Directory Listing vulnerabilities'
    steps: [
        * def directoryListing = 'public/';
        given url 'http://api.example.com/{directoryListing}'
        when method get
        then status 403
        and match response contains 'Access denied',
        scenario: 'Test API for Insecure Redirection via Header vulnerabilities'
    steps: [
        * def headerUrl = 'http://api.example.com/redirect/{userId}';
        when method get
        then status 400
        and match response contains 'Invalid redirection URL',
        scenario: 'Test API for Insecure Redirection via Parameter vulnerabilities'
    steps: [
        * def paramUrl = 'http://api.example.com/redirect/{userId}';
        when method get
        then status 400
        and match response contains 'Invalid redirection URL',
        scenario: 'Test API for Insecure Redirection via