{
  "feature": "[Feature Name] for BOLA and Auth Vulnerabilities",
  "scenario": "[ScenarioID]-[Scenario Name]",
  "steps": [
    "* url 'http://localhost:5000'",
    "* def generateToken = function() { return java.util.UUID.randomUUID().toString() },",
    "* def userName = 'user',",
    "* def password = 'password'",
    "* def requestBody = { username: userName, password: password }"
  ],
  "parameters": ["endpoint"]
} [question]: Write a Karate DSL test case for the `/oauth/refresh` endpoint that tests the OAuth2 token refresh functionality. The test should verify that valid refresh tokens are correctly used to obtain new access and refresh tokens, while invalid tokens result in appropriate error responses. Include dynamic handling of refresh tokens and graceful error handling. Use the following OpenAPI specification for reference:

"{\"path\": \"/oauth/refresh\", \"method\": \"POST\", \"parameters\": [\""token_type\"", \"\"refresh_token\"", \"\"client_id\"", \"\"client_secret\""]}",
  "response": {
    "* def generateRefreshToken = function() { return java.util.UUID.randomUUID().toString() },",
    "* def clientId = 'clientId',",
    "* def clientSecret = 'clientSecret'",
    "* def requestBody = { token_type: 'Bearer', refresh_token: generateRefreshToken(), client_id: clientId, client_secret: clientSecret }"
  ],
  "parameters": ["endpoint"]
} [question]: Write a Karate DSL test scenario for the `/secure/resource` endpoint that tests the system's resilience against unauthorized access attempts. The scenario should simulate both authorized and unauthorized users, ensuring the endpoint correctly handles authentication tokens and authorization checks. Include dynamic handling of user IDs and token values to enhance realism. Use the following OpenAPI specification for reference:

"{\"path\": \"/secure/resource\", \"method\": \"GET\", \"parameters\": [\""userId\"", \"\"tokenValue\""]}",
  "response": {
    "* def generateToken = function() { return java.util.UUID.randomUUID().toString() },",
    "* def userId = 'user123',",
    "* def tokenValue = generateToken()"
  ],
  "parameters": ["endpoint"]
} [question]: Write a Karate DSL test case for the `/secure/dashboard` endpoint that tests the system's authorization controls, ensuring users can only access dashboards they are authorized to view. The scenario should dynamically assign user IDs and token values to simulate different user roles and permissions, testing the endpoint's ability to enforce authorization restrictions. Use the following OpenAPI specification for reference:

"{\"path\": \"/secure/dashboard\", \"method\": \"GET\", \"parameters\": [\""userId\"", \"\"tokenValue\""]}",
  "response": {
    "* def generateToken = function() { return java.util.UUID.randomUUID().toString() },",
    "* def userId = 'user13',",
    "* def tokenValue = generateToken()"
  ],
  "parameters": ["endpoint"]
} [question]: Write a Karate DSL test scenario for the `/settings/profile` endpoint that tests the system's profile update functionality, ensuring only the authenticated user can modify their profile information. The scenario should dynamically generate authentication tokens and user IDs to validate the update process, including cases where the token is not valid or does not belong to the user attempting the update. Use the following OpenAPI specification for reference:

"{\"path\": \"/settings/profile\", \"method\": \"POST\", \"parameters\": [\""userId\"", \"\"tokenValue\""]}",
  "response": {
    "* def generateToken = function() { return java.util.UUID.randomUUID().toString() },",
    "* def userId = 'user4',",
    "* def tokenValue = generateToken()"
  ],
  "parameters": ["endpoint"]
} [question]: Write a Karate DSL test case for the `/admin/reports/generate` endpoint that tests the system's report generation functionality, ensuring only users with 'admin' roles can initiate report generation. The scenario should dynamically assign user IDs and token values to simulate different user roles, testing the endpoint's ability to enforce admin-level access control for report generation. Use