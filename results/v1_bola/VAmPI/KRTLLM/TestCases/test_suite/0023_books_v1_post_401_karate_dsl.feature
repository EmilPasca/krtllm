feature: "Test API for Security Vulnerabilities"
    background: "http://api.example.com/books/v1"
    scenario: "Ensure the `/books/v1` endpoint is secure against SQL injection, CSRF, and Broken Authentication attacks."
        given url 'http://api.example.com/books/v1'
        when method post
        then status 403

        match response contains 'Invalid Token',
        assert !response.contains('error'),
        assert response does not contain '; DROP TABLE books;',
        assert response does not contain '<script>alert(1)</script>',
        assert response does not contain 'admin' unless request.header('Authorization') == 'Bearer <user_token>'
    Background: "http://api.example.com/books/v1"
    Scenario: "Ensure the `/books/v1` endpoint is secure against CSRF attacks."
        given url 'http://api.example.com/books/v1'
        when method post
        then status 403

        match response contains 'CSRF token mismatch',
        assert !response.contains('error'),
        assert response does not contain '; DROP TABLE books;',
        assert response does not contain '<script>alert(1)</script>',
        assert response does not contain 'admin' unless request.header('Authorization') == 'Bearer <user_token>'
    Background: "http://api.example.com/books/v1"
    Scenario: "Ensure the `/books/v1` endpoint is secure against Broken Authentication attempts."
        given url 'http://api.example.com/books/v1'
        when method post
        then status 403

        match response contains 'Invalid Username or Password',
        assert !response.contains('error'),
        assert response does not contain '; DROP TABLE books;',
        assert response does not contain '<script>alert(1)</script>',
        assert response does not contain 'admin' unless request.header('Authorization') == 'Bearer <user_token>'
    Background: "http://api.example.com/books/v1"
    Scenario: "Ensure the `/books/v1` endpoint is secure against unauthorized access attempts."
        given url 'http://api.example.com/books/v1'
        when method post
        then status 403

        match response contains 'Access denied',
        assert !response.contains('error'),
        assert response does not contain '; DROP TABLE books;',
        assert response does not contain '<script>alert(1)</script>',
        assert response does not contain 'admin' unless request.header('Authorization') == 'Bearer <user_token>'
    Background: "http://api.example.com/books/v1"
    Scenario: "Ensure the `/books/v1` endpoint is secure against unauthorized data access attempts."
        given url 'http://api.example.com/books/v1'
        when method post
        then status 403

        match response contains 'Access not allowed',
        assert !response.contains('error'),
        assert response does not contain '; DROP TABLE books;',
        assert response does not contain '<script>alert(1)</script>',
        assert response does not contain 'admin' unless request.header('Authorization') == 'Bearer <user_token>'
    Background: "http://api.example.com/books/v1"
    Scenario: "Ensure the `/books/v1` endpoint is secure against unauthorized data modification attempts."
        given url 'http://api.example.com/books/v1'
        when method post
        then status 403

        match response contains 'Access denied for modification',
        assert !response.contains('error'),
        assert response does not contain '; DROP TABLE books;',
        assert response does not contain '<script>alert(1)</script>',
        assert response does not contain 'admin' unless request.header('Authorization') == 'Bearer <user_token>'
    Background: "http://api.example.com/books/v1"
    Scenario: "Ensure the `/books/v1` endpoint is secure against unauthorized data deletion attempts."
        given url 'http://api.example.com/books/v1'
        when method post
        then status 403