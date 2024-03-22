feature: 'API Security Testing with Karate DSL'
scenario: 'Test API for SQL Injection, Broken Authentication, CSRF and other vulnerabilities'
steps: [
    * def username = 'user5',
    * def oldEmail = 'old@example.com',
    * def newEmail = 'new@example.com',
    given url 'http://api.example.com/users/v1/' + username + '/email'
    when method post { email: newEmail }
    then status 400
    and match response contains 'Please Provide a valid email address.'
    * def maliciousPayload = read('classpath:helpers/maliciousPayloads.json')
    when method post maliciousPayload
    then status 200 or status 400
    and assert !response.contains('error'),
    given headers Authorization = 'Bearer <token>'
    when method get '/secure/endpoint'
    then status 200
    and match response contains 'Secure Endpoint Accessed Successfully.',
    * def sessionId = read('classpath:helpers/generateSessionId.js')
    given headers Cookie = 'sessionId=' + sessionId
    when method get '/session/secure'
    then status 200
    and match response contains 'Secure Session Accessed Successfully.'
    * def userIds = read('classpath:helpers/userIds.json')
    given params userId = userIds[0]
    when method get '/user/{userId}'
    then status 403
    and assert !response.contains('Access denied'),
    given headers Authorization = 'Bearer <other_token>'
    when method post '/api/post'
    then status 200 or status 400
    and match response contains 'Posted successfully.',
    * def csrfToken = read('classpath:security/generateCsrfToken.js')
    given headers Csrftoken = csrfToken
    when method post '/csrf/secure'
    then status 200
    and match response contains 'CSRF token verified successfully.'
]} [question]: Write a Karate DSL test case for the `/api/rateLimit` endpoint that tests the API's rate limiting and DDoS protection mechanisms, including tests for exceeding request limits. The test should verify that the API enforces rate limiting, rejecting requests when the limit is exceeded. Depending on the required fields (body params, query params, assertion types and so on) The scenario should be structured as follows:

Feature: [Feature Name]
    Background:
         * [Background details such as URL path/headers]
    Scenario: [ScenarioID]-[Scenario Name]
         Given url/path
         And request body (if any)
         And headers 
         When method POST/PUT/GET/DELETE
         Then status

         And match body (if any)

Include only the required Karate DSL code for the java feature scenario code. The scenario should include the endpoint path, request headers, and a JSON body (if required) with all required fields as per the schema. Validate the response to ensure it has the required status code and the response body matches the expected schema. Include dynamic data handling for fields where applicable and, ensure that common setup steps are in the Background section.Handle potential error responses gracefully. Use the following OpenAPI specification for the scenario generation:

"{\"path\": \"/api/rateLimit\", \"method\": \"GET\", \"responses\": {\"200\": {\"description\": \"Rate limiting and DDoS protection test passed\", \"content\": {\"application/json\": {\"schema\": {\"type\": \"object\", \"properties\": {\"status\": {\"type\": \"string\", \"enum\": [\"success\"], \"example\": \"success\"}, \"message\": {\"type\": \"string\", \"example\": \"Rate limiting and DDoS protection tests passed successfully.\"}}}}}, "required": true}, "parameters": [{"name": "limit", "in": "query", "description": "Limit the number of requests", "required": false, "schema": {"type": "number", "minimum": 1, "maximum": 10, "example": 5}}]}"