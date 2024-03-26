feature: Test API for BOLA and Authentication Vulnerabilities with Dynamic Token Handling
    background: url 'http://localhost:5000'
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Flaws with Dynamic Tokens
        given path '/books/v1/{book_title}'
        And request { token: 'dynamicToken', book_title: 'testBookTitle' }
        When method GET
        Then status 200 or 403
        And match response contains 'Access granted' if status == 200 else 'Access denied'
        And assert response.contains('book data') if status == 200 else response.contains('Unauthorized access attempt detected'),
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Flaws with Dynamic Tokens (Different User)
        given path '/books/v1/{book_title}'
        And request { token: 'dynamicTokenOtherUser', book_title: 'testBookTitle' }
        When method GET
        Then status 403
        And match response contains 'Unauthorized access attempt detected',
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Flaws with Dynamic Tokens (Invalid Token)
        given path '/books/v1/{book_title}'
        And request { token: 'invalidToken', book_title: 'testBookTitle' }
        When method GET
        Then status 403
        And match response contains 'Invalid token',
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Flaws with Dynamic Tokens (Unauthorized User)
        given path '/books/v1/{book_title}'
        And request { token: 'userToken', book_title: 'testBookTitle' }
        When method GET
        Then status 403
        And match response contains 'User does not have permission to access this resource.',
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Flaws with Dynamic Tokens (Authorized User)
        given path '/books/v1/{book_title}'
        And request { token: 'adminToken', book_title: 'testBookTitle' }
        When method GET
        Then status 200
        And match response contains 'Access granted. Book data: ',
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Flaws with Dynamic Tokens (Unauthorized Resource Access)
        given path '/books/v1/{book_title}'
        And request { token: 'userToken', book_title: 'adminBookTitle' }
        When method GET
        Then status 403
        And match response contains 'User does not have permission to access this resource.',
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Flaws with Dynamic Tokens (Authorized User, Unauthorized Resource)
        given path '/books/v1/{book_title}'
        And request { token: 'adminToken', book_title: 'userBookTitle' }
        When method GET
        Then status 200
        And match response contains 'Access granted. Book data: ',
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Flaws with Dynamic Tokens (Unauthorized User, Unauthorized Resource)
        given path '/books/v1/{book_title}'
        And request { token: 'userToken', book_title: 'userBookTitle' }
        When method GET
        Then status 403
        And match response contains 'User does not have permission to access this resource.',
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Flaws with Dynamic Tokens (Unauthorized User, Admin Resource)
        given path '/books/v1/{book_title}'
        And request { token: 'userToken', book_title: 'adminBookTitle' }
        When method GET
        Then status 403
        And match response contains 'User does not have permission to access this resource.',
    scenario: [ScenarioID]-Test Endpoint for BOLA and Auth Flaws with Dynamic Tokens (Authorized User, Admin Resource)
        given path '/books/v1/{book_title}'
        And request { token: 'adminToken', book_title: 'adminBookTitle' }
        When method GET
        Then status 200
        And match response contains 'Access