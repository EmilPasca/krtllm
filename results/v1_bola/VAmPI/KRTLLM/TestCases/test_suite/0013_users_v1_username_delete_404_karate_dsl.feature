Feature: API Security Testing with Dynamic Data Handling and Error Handling
    Background: url 'http://api.example.com/users/{userId}'
    Scenario: 001-Test for API Endpoint Security with Dynamic User IDs
         Given method get
         And param userId = function(){ return karate.faker.random.numeric(5) }
         When header Authorization = 'Bearer <token>'
         Then status 200 or status 403

         And match response contains 'User found' if status == 200 else 'Access denied',

Include only the required Karate DSL code for the java feature scenario code. The scenario should include the endpoint path, request headers, and a JSON body (if required) with all required fields as per the schema. Validate the response to ensure it has the required status code and the response body matches the expected schema. Include dynamic data handling for fields where applicable and, ensure that common setup steps are in the Background section.Handle potential error responses gracefully. Use the following OpenAPI specification for the scenario generation:

"{\"path\": \"/users/{userId}\", \"method\": \"GET\", \"responses\": {\"200\": {\"description\": \"User found\", \"content\": {\"application/json\": {\"schema\": {\"type\": \"object\", \"properties\": {\"status\": {\"type\": \"string\", \"example\": \"success\", \"enum\": [\"success\"]}, \"message\": {\"type\": \"string\", \"example\": \"User found!\"}}}}}}}, \"requestBody\": {}, \"parameters\": [{\"name\": \"userId\", \"in\": \"path\", \"description\": \"Get user by ID\", \"required\": true, \"schema\": {\"type\": \"string\", \"example\": \"user123\", "