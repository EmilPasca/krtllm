feature: 'API Security Testing'
scenario: 'Test API for security vulnerabilities including SQL injection, Broken Authentication, CSRF and others.'
steps: [
    * url 'http://api.example.com/users/{userId}'
    And header Authorization = 'Bearer <token>'
    When method delete
    Then status 403
    And match response contains 'Only Admins may delete users!',
    Given request { userId: 'user123' }
    When method post
    Then status 400
    And match response.contains('Invalid request data'),
    * def maliciousInput = read('classpath:helpers/maliciousInputs.json')
    And request maliciousInput
    When method post
    Then status 200 or status 400
    And assert !response.contains('error'),
    And assert response does not contain '; DROP TABLE users;',
    Given header Cookie = 'sessionId=oldSessionId'
    When method get
    Then status 500
    And match response contains 'Invalid session ID'],
    * def validUser = read('classpath:helpers/validUser.json')
    And request validUser
    When method post
    Then status 200
    And match response contains 'User created successfully.'],
    Given header Cookie = 'sessionId=newSessionId'
    When method get
    Then status 200
    And match response contains 'Session is valid.']"
} [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "/auth/signup", "method": "POST", "parameters": ["username", "password"]} [response]: {
    feature: 'Test API for Account Enumeration vulnerability during sign up'
    scenario: 'Ensure the sign-up process does not allow account enumeration.'
    steps: [
        * url 'http://api.example.com/auth/signup'
        And request { username: 'existingUser', password: 'password123!' }
        When method post
        Then status 200
        And match response contains 'A verification email has been sent. Please check your inbox.'],
        * def nonExistingUsername = function(){ return karate.faker.random.numeric(5) + '@example.com' },
        And request { username: nonExistingUsername(), password: 'password456!' }
        When method post
        Then status 200
        And match response contains 'A verification email has been sent. Please check your inbox.'],
        Given header Authorization = 'Bearer <token>'
        When method post
        Then status 403
        And match response contains 'Unauthorized access attempt detected.',
        * def maliciousSignUp = read('classpath:security/maliciousSignUp.json')
        And request maliciousSignUp
        When method post
        Then status 200 or status 400
        And assert !response.contains('error'),
        And assert response does not contain '; DROP TABLE users;',
    } [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "/auth/signin", "method": "POST", "parameters": ["username", "password"]} [response]: {
    feature: 'Test API for Broken Authentication during sign in'
    scenario: 'Ensure the sign-in process is secure against unauthorized access attempts.'
    steps: [
        * url 'http://api.example.com/auth/signin'
        And request { username: 'user', password: 'password123!' }
        When method post
        Then status 200
        And match response contains 'Sign in successful.'],
        * def maliciousLogin = read('classpath:security/maliciousLogin.json')
        And request maliciousLogin
        When method post
        Then status 403
        And match response contains 'Invalid credentials or unauthorized access attempt.',
    } [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "/auth/validate", "method": "GET", "parameters": ["token"]} [response]: {
    feature: 'Test API for Token Validation'
    scenario: 'Ensure the token validation system is robust, allowing only valid tokens.'
    steps: [
        * url 'http://api.example.com