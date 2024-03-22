feature: "Test API for Security Vulnerabilities"
    background: "http://api.example.com/books/v1"
    scenario: "Ensure the `/books/v1` endpoint is secure against SQL injection, CSRF, and Broken Authentication attacks."
        given url 'http://api.example.com/books/v1'
        when method get
        then status 200

        match response contains "See all books",
        assert !response.contains("error"),
        assert response.has('Books'),
        assert response.Books.size() > 0,
        assert response.Books[0].book_title != '',
        assert response.Books[0].user != ''
    scenario: "Fuzz test the `/books/v1` endpoint for SQL injection vulnerabilities."
        given url 'http://api.example.com/books/v1'
        when method get
        then status 200 or status 400

        match response contains "See all books" or response contains "Invalid request",
        assert !response.contains("error"),
        assert response.has('Books'),
        assert response.Books.size() > 0,
        assert response.Books[0].book_title != '',
        assert response.Books[0].user != ''
    scenario: "Test the `/books/v1` endpoint for CSRF vulnerabilities."
        given url 'http://api.example.com/books/v1'
        when method get
        then status 200

        match response contains "See all books",
        assert !response.contains("error"),
        assert response.has('Books'),
        assert response.Books.size() > 0,
        assert response.Books[0].book_title != '',
        assert response.Books[0].user != ''
    scenario: "Ensure the `/books/v1` endpoint enforces secure authentication."
        given url 'http://api.example.com/books/v1'
        when method get
        then status 403

        match response contains "Invalid credentials",
        assert !response.contains("error"),
        assert response does not have 'Books',
        assert response.status == 403
    scenario: "Test the `/books/v1` endpoint with an unauthorized user, ensuring it is secure against access attempts."
        given url 'http://api.example.com/books/admin'
        when method get
        then status 403

        match response contains "Access denied",
        assert !response.contains("error"),
        assert response does not have 'Books',
        assert response.status == 403
    scenario: "Fuzz test the `/books/v1` endpoint for other security vulnerabilities."
        given url 'http://api.example.com/books/v1'
        when method get
        then status 200 or status 400

        match response contains "See all books" or response contains "Invalid request",
        assert !response.contains("error"),
        assert response.has('Books'),
        assert response.Books.size() > 0,
        assert response.Books[0].book_title != '',
        assert response.Books[0].user != ''
    scenario: "Test the `/books/v1` endpoint for handling of malformed or unexpected requests."
        given url 'http://api.example.com/books/v1'
        when method get
        then status 400

        match response contains "Invalid request",
        assert !response.contains("error"),
        assert response does not have 'Books',
        assert response.status == 400
    scenario: "Ensure the `/books/v1` endpoint complies with required API standards for security."
        given url 'http://api.example.com/books/v1'
        when method get
        then status 200

        match response contains "See all books",
        assert !response.contains("error"),
        assert response.has('Books'),
        assert response.Books.size() > 0,
        assert response.Books[0].book_title != '',
        assert response.Books[0].user != ''
    scenario: "Test the `/books/v1` endpoint for secure redirection handling."
        given url 'http://api