feature: Test API for BOLA and Authentication Vulnerabilities
    background: url 'http://localhost:5000'
    scenario: "Test the `/users/{userId}/admin` endpoint for unauthorized access attempts"
        given path '/users/{userId}/admin'
        when method POST
        then status 403
        and match response contains 'Access denied. Admin rights required.',
        given header Authorization = 'Bearer <user_token>'
        when method GET
        then status 200
        and match response contains 'User details fetched successfully.'
    scenario: "Ensure the `/admin/{action}` endpoint enforces strict authorization checks"
        given path '/admin/{action}'
        when method POST
        then status 403
        and match response contains 'Access denied. Admin rights required.',
        given header Authorization = 'Bearer <admin_token>'
        when method GET
        then status 200
        and match response contains 'Admin actions dashboard.'
    scenario: "Test the `/user/{userId}/promote` endpoint for unauthorized user promotion"
        given path '/user/{userId}/promote'
        when method POST
        then status 403
        and match response contains 'Unauthorized to promote users.',
        given header Authorization = 'Bearer <admin_token>'
        when method POST
        then status 200
        and match response contains 'User promoted successfully.'
    scenario: "Ensure the `/settings/{settingId}/update` endpoint is securely protected against unauthorized updates"
        given path '/settings/{settingId}/update'
        when method POST
        then status 403
        and match response contains 'Access denied for settings update.',
        given header Authorization = 'Bearer <admin_token>'
        when method POST
        then status 200
        and match response contains 'Settings updated successfully.'
    scenario: "Test the `/user/{userId}/follow` endpoint for unauthorized user follow actions"
        given path '/user/{userId}/follow'
        when method POST
        then status 403
        and match response contains 'Unauthorized to follow users.',
        given header Authorization = 'Bearer <user_token>'
        when method POST
        then status 200
        and match response contains 'User followed successfully.'
    scenario: "Ensure the `/profile/{userId}/update` endpoint is securely protected against unauthorized profile updates"
        given path '/profile/{userId}/update'
        when method POST
        then status 403
        and match response contains 'Access denied for profile update.',
        given header Authorization = 'Bearer <user_token>'
        when method POST
        then status 200
        and match response contains 'Profile updated successfully.'
 [question]: Write me a security test case using karate DSL scenario specifically targeting API security testing for vulnerabilities such as Broken Object Level Authorization (BOLA), Authentication Flaws, and Authorization Issues. Tailor the scenarios to handle and validate authentication tokens, ensure proper authorization checks, and avoid common pitfalls like hardcoded endpoints. Structure the scenario with dynamic data handling for authentication tokens and include domain-specific endpoint paths to enhance realism. The scenario structure is as follows:

Feature: [Feature Name] for BOLA and Auth Vulnerabilities
    Background:
         * url 'http://localhost:5000'
    Scenario: [ScenarioID]-[Scenario Name]
         Given path '[endpoint]'
         And request [request details]
         When method POST/PUT/GET/DELETE
         Then status 200/401/403
         And match response body to expected schema

Include only the essential Karate DSL code for the java feature scenario. Ensure the scenario comprehensively covers the endpoint path, request headers, and JSON body (if required) with all fields as per the schema. Emphasize dynamic data handling for tokens and sensitive fields, ensuring that setup steps common to BOLA and authentication tests are detailed in the Background section. Gracefully handle potential error responses.
For scenario generation, use the specific OpenAPI specification provided:

"{\"path\": \"/users/v1/{username}\", \"method\": \"DELETE\", \"responses\": {\"200\": {\"description\": \"Sucessfully deleted user\", \"content\": {\"application/json\": {\"schema\": {\"type