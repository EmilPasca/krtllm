feature: 'API Security Testing with Karate DSL'
scenario: 'Test API for SQL Injection and Broken Authentication vulnerabilities'
steps: [
    * def username = 'user57',
    * def password = 'pass123',
    * def newPassword = 'newPass456',
    given url 'http://api.example.com/users/{username}/password'
    when method post
    then status 400
    and match response contains 'Invalid username or password'
    * def checkSqlInjectionVulnerability = call read('classpath:helpers/checkSqlInjection.js')
    * assert !checkSqlInjectionVulnerability(response)
    * def checkBrokenAuthenticationVulnerability = call read('classpath:security/checkBrokenAuthentication.js')
    * assert checkBrokenAuthenticationVulnerability(response) == true
]"{\"path\": \"/auth/signup\", \"method\": \"POST\", \"responses\": {\"200\": {\"description\": \"User signed up successfully\", \"content\": {}}}, \"requestBody\": {\"description\": \"Registers a new user\", \"content\": {\"application/json\": {\"schema\": {\"type\": \"object\", \"properties\": {\"username\": {\"type\": \"string\", \"example\": \"newuser\"}}, \"password\": {\"type\": \"string\", \"example\": \"123456\"}}}, "required": true,} [{"name": "username", "in": "path", "description": "Username to check for existence", "required": true, "schema": {"type": "string", "example": "existinguser"}},]}"