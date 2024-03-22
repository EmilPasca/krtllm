feature: 'API Security Testing'
scenario: 'Test API for security vulnerabilities including SQL injection, Broken Authentication, and CSRF.'
steps: [
    * def usernames = read('classpath:helpers/usernames.json')
    Given url 'http://api.example.com/users/{username}'
    And header Authorization = 'Bearer <token>'
    When method get
    Then status 200 or status 404
    And match response contains { status: 'ok' } when status 200, { status: 'User not found' } when status 404
    foreach usernames, function(username){
        And param username = username
        When method get
        Then status != 500 or status == 200 || status == 404
        And match response contains { status: 'ok' } when status 200, { status: 'User not found' } when status 404
    }
} [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "/auth/signup", "method": "POST", "summary": "Registers a new user account", "parameters": ["username", "password"]}

"{\"path\": \"/auth/signup\", \"method\": \"POST\", \"responses\": {\"400\": {\"description\": \"Invalid registration data\", \"content\": {\"application/json\": {\"schema\": {\"type\": \"object\", \"properties\": {\"status\": {\"type\": \"string\", \"enum\": [\"fail\"], \"example\": \"fail\"}, \"message\": {\"type\": \"string\", \"example\": \"Invalid registration data\"}}}}}}}, \"requestBody\": {"username": "testUser", "password": "testPass"}, "parameters\": ["username", "password"]}"