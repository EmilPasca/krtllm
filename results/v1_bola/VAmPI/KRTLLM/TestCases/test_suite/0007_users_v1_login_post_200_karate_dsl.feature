feature: API Security Testing with Karate DSL
    background: URL path '/users/v1/login' and request headers { Authorization: 'Bearer <token>' }
    scenario: "Test for API security vulnerabilities including SQL injection, Broken Authentication, CSRF, etc."
        given method post
        when request { username: 'user', password: 'password' }
        then status 200

        and match response contains 'Successfully logged in.'

        and assert !response.contains('Error'), 'Invalid response format.'
    Background: URL path '/users/v1/login' and request headers { Authorization: 'Bearer <token>' }
    Scenario: "Test for API security vulnerabilities including SQL injection, Broken Authentication, CSRF, etc."
        given method post
        when request { username: ' OR 1=1', password: ' AND 1=1' }
        then status 400

        and match response contains 'Invalid login credentials.',

        and assert !response.contains('Error'), 'Invalid response format.'
    Background: URL path '/users/v1/login' and request headers { Authorization: 'Bearer <token>' }
    Scenario: "Test for API security vulnerabilities including SQL injection, Broken Authentication, CSRF, etc."
        given method post
        when request { username: '<script>alert(1)</script>', password: 'password' }
        then status 400

        and match response does not contain 'Script',

        and assert !response.contains('Error'), 'Invalid response format.'
    Background: URL path '/users/v1/login' and request headers { Authorization: 'Bearer <token>' }
    Scenario: "Test for API security vulnerabilities including SQL injection, Broken Authentication, CSRF, etc."
        given method post
        when header Authorization = 'Bearer <token_of_another_user>' and request { username: 'user', password: 'password' }
        then status 403

        and match response contains 'Unauthorized access attempt detected.',

        and assert !response.contains('Error'), 'Invalid response format.'
    Background: URL path '/users/v1/login' and request headers { Authorization: 'Bearer <token>' }
    Scenario: "Test for API security vulnerabilities including SQL injection, Broken Authentication, CSRF, etc."
        given method post
        when header Authorization = 'Bearer <token>' and request { username: '', password: '' }
        then status 400

        and match response contains 'Invalid login details.',

        and assert !response.contains('Error'), 'Invalid response format.'
    Background: URL path '/users/v1/login' and request headers { Authorization: 'Bearer <token>' }
    Scenario: "Test for API security vulnerabilities including SQL injection, Broken Authentication, CSRF, etc."
        given method post
        when header Authorization = 'Bearer <token>' and request { username: 'user', password: '' }
        then status 400

        and match response contains 'Invalid login details.',

        and assert !response.contains('Error'), 'Invalid response format.'
    Background: URL path '/users/v1/login' and request headers { Authorization: 'Bearer <token>' }
    Scenario: "Test for API security vulnerabilities including SQL injection, Broken Authentication, CSRF, etc."
        given method post
        when header Authorization = 'Bearer <token>' and request { username: '', password: 'password' }
        then status 400

        and match response contains 'Invalid login details.',

        and assert !response.contains('Error'), 'Invalid response format.'
    Background: URL path '/users/v1/login' and request headers { Authorization: 'Bearer <token>' }
    Scenario: "Test for API security vulnerabilities including SQL injection, Broken Authentication, CSRF, etc."
        given method post
        when header Authorization = 'Bearer <token_of_another_user>' and request { username: 'user', password: 'password' }
        then status 403

        and match response contains 'Unauthorized access attempt detected.',

        and assert !response.contains('Error'), 'Invalid response format.'
    Background: URL path '/users/v1/login' and request headers