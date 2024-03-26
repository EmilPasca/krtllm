feature: 'Test API for BOLA and Authentication Vulnerabilities'
    background: url 'http://localhost:5000'
    scenario: 'Ensure the `/books/v1/{book_title}` endpoint is secure against BOLA and authentication flaws, dynamically testing with different book titles and tokens.'
        given path '/books/v1/{book_title}'
        when method get
        then status 200 or status 403 or status 401
        and match response contains 'Book info retrieved successfully.', unless response.status == 403 || response.status == 401
        and assert response.contains('Access denied.'), unless response.status == 200
        when method get with header Authorization = 'Bearer <token>'
        then status 200 or status 403 or status 401
        and match response contains 'Book info retrieved successfully.', unless response.status == 403 || response.status == 401
        when method get with header Authorization = 'Bearer <other_token>'
        then status 200 or status 403 or status 401
        and match response contains 'Book info retrieved successfully.', unless response.status == 403 || response.status == 401
    scenario: 'Dynamically test the `/books/v1/{book_title}` endpoint with different book titles and tokens to ensure robust security measures.'
        foreach ['bookTitle77', 'bookTitle88', 'bookTitle99'], function(title){
            when method get with header Authorization = 'Bearer <token>' and param book_title = title
            then status 200 or status 403 or status 401
            and match response contains 'Book info retrieved successfully.', unless response.status == 403 || response.status == 401
        }
    scenario: 'Ensure the API correctly handles authentication tokens for secure access.'
        when method get with header Authorization = 'Bearer <valid_token>'
        then status 200
        and match response contains 'Token is valid.', unless response.contains('Invalid token')
        when method get with header Authorization = 'Bearer <invalid_token>'
        then status 403 or status 401
        and match response contains 'Invalid token.'
    scenario: 'Test the endpoint for unauthorized access attempts, ensuring the API enforces strict authorization controls.'
        when method get with header Authorization = 'Bearer <user_token>' and param book_title = 'bookTitle77'
        then status 403 or status 401
        and match response contains 'Access not allowed.', unless response.contains('Invalid token')
    scenario: 'Ensure the API rejects hardcoded endpoints or other security misconfigurations.'
        when method get url 'http://localhost:5000/books/v1/hardcoded'
        then status 403 or status 404
        and match response contains 'Endpoint not found or access unauthorized.', unless response.contains('Internal Server Error')
    scenario: 'Test the endpoint with an unknown book title to ensure robust handling of such requests.'
        when method get with header Authorization = 'Bearer <token>' and param book_title = 'unknownTitle'
        then status 404
        and match response contains 'Book not found.', unless response.contains('Internal Server Error')
    scenario: 'Ensure the API responds gracefully to potential error scenarios, such as invalid token or unauthorized access attempts.'
        when method get with header Authorization = 'Bearer <invalid_token>'
        then status 403 or status 401
        and match response contains 'Invalid token.', unless response.contains('Internal Server Error')
    scenario: 'Test the endpoint for BOLA vulnerabilities by ensuring users cannot access books they do not own.'
        when method get with header Authorization = 'Bearer <user_token>' and param book_title = 'otherUserBook'
        then status 403 or status 401
        and match response contains 'Access not allowed.', unless response.contains('Invalid token')
    scenario: 'Ensure the API correctly handles sensitive fields like `secret` to prevent unauthorized access.'
        when method get with header Authorization = 'Bearer <user_token>' and param book_title = 'bookTitle77'
        then status 4