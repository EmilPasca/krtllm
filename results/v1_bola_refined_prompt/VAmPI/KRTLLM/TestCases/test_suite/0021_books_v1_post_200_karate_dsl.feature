feature: Test API for BOLA and Authentication Flaws with Dynamic Token Handling
    background: url 'http://localhost:5000'
    scenario: [ScenarioID]-Test API Endpoint Securely with Dynamic Tokens
        given path '/books/v1'
        And header Authorization = 'Bearer <dynamic token>'
        When method POST
        Then status 200 or 403
        And match response.contains('Book added successfully.'),
        Given header Authorization = 'Bearer <other dynamic token>'
        When method GET
        Then status 200 or 403
        And match response.contains('Accessing book list successful.'),
        Given header Authorization = 'Invalid_Token'
        When method POST
        Then status 403
        And match response contains 'Invalid token.'
    scenario: [ScenarioID]-Test Endpoint for Authorization Issues with Dynamic Tokens
        given path '/user/profile/v1'
        And header Authorization = 'Bearer <dynamic token>'
        When method GET
        Then status 200 or 403
        And match response.contains('User profile data'),
        Given header Authorization = 'Other_Dynamic_Token'
        When method GET
        Then status 403
        And match response contains 'Unauthorized access.'
    scenario: [ScenarioID]-Test Endpoint for BOLA with Dynamic Tokens and Sensitive Data Handling
        given path '/user/data/v1'
        And header Authorization = 'Bearer <dynamic token>'
        When method GET
        Then status 200 or 403
        And match response.contains('User data'),
        Given parameter userId = '<userId>',
        And match response contains 'UserId: ' + userId,
        Given header Authorization = 'Bearer <other dynamic token>'
        When method GET
        Then status 403
        And match response contains 'Unauthorized access to user data.'
    scenario: [ScenarioID]-Test Endpoint for BOLA with Hardcoded Tokens and Sensitive Data Handling
        given path '/user/data/v1'
        And header Authorization = 'Bearer <hardcoded token>'
        When method GET
        Then status 200 or 403
        And match response.contains('User data'),
        Given parameter userId = 'user5',
        And match response contains 'UserId: user5'
    scenario: [ScenarioID]-Test Endpoint for BOLA with Unauthorized User Id
        given path '/user/data/v1'
        And header Authorization = 'Bearer <dynamic token>'
        When method GET
        Then status 403
        And match response contains 'Unauthorized access to user data.'
    scenario: [ScenarioID]-Test Endpoint for BOLA with Authorized User Id
        given path '/user/data/v1'
        And header Authorization = 'Bearer <dynamic token>'
        When method GET
        Then status 200 or 403
        And match response.contains('User data'),
        Given parameter userId = '<authorizedUserId>',
        And match response contains 'UserId: ' + authorizedUserId,
        Given header Authorization = 'Bearer <other dynamic token>'
        When method GET
        Then status 403
        And match response contains 'Unauthorized access to user data.'
    scenario: [ScenarioID]-Test Endpoint for BOLA with Unknown User Id
        given path '/user/data/v1'
        And header Authorization = 'Bearer <dynamic token>'
        When method GET
        Then status 403
        And match response contains 'User ID not found.'
    scenario: [ScenarioID]-Test Endpoint for BOLA with Known User Id but Unauthorized Access
        given path '/user/data/v1'
        And header Authorization = 'Bearer <dynamic token>'
        When method GET
        Then status 403
        And match response contains 'Access not authorized.'
    scenario: [ScenarioID]-Test Endpoint for BOLA with Known User Id and Authorized Access
        given path '/user/data/v1'
        And header Authorization = 'Bearer <dynamic token>'
        When method GET
        Then status 200 or 403