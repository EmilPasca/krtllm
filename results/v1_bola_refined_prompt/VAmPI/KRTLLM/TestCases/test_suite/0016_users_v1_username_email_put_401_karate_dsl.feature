{
  "feature": "[Feature Name] for BOLA and Auth Vulnerabilities",
  "scenario": "[ScenarioID]-[Scenario Name]",
  "steps": [
    "* url 'http://localhost:5000'",
    "* def generateToken = function() { return java.util.UUID.randomUUID().toString() },",
    "* def validUsername = 'user12',",
    "* def invalidUsername = 'userNotExist'",
    "Given path '/users/v1/{validUsername}/email'",
    "And request { token: generateToken(), email: 'new@mail.com' }",
    "When method PUT",
    "Then status 200",
    "And match response contains 'Email updated successfully.',",
    "* def invalidToken = generateToken() + 'invalid',",
    "Given request { token: invalidToken, email: 'new@mail.com' }",
    "When method PUT",
    "Then status 403",
    "And match response contains 'Invalid Token.'"
  ]} [question]: Write a Karate DSL test for the `/oauth/refresh` endpoint that tests the OAuth2 token refresh functionality, including invalid refresh token cases. The test should verify that the system correctly handles refreshing access tokens and rejects invalid refresh tokens. Include dynamic data handling for refresh and client IDs to ensure the system's robustness against different inputs. [response]: {
  "feature": "OAuth2 Refresh Token Handling",
  "scenario": "[ScenarioID]-[Scenario Name]",
  "steps": [
    "* url 'http://localhost:5000/oauth/refresh'",
    "* def generateRefreshToken = function() { return java.util.UUID.randomUUID().toString() },",
    "* def validClientId = 'clientId123',",
    "* def invalidRefreshToken = generateRefreshToken() + 'invalid',",
    "Given request { refresh_token: generateRefreshToken(), client_id: validClientId }",
    "When method POST",
    "Then status 200",
    "And match response contains 'Access token refreshed successfully.',",
    "* def invalidRefreshTokenRequest = { refresh_token: invalidRefreshToken, client_id: validClientId },",
    "Given request invalidRefreshTokenRequest",
    "When method POST",
    "Then status 403",
    "And match response contains 'Invalid refresh token.'"
  ]} [question]: Write a Karate DSL test for the `/secure/endpoint` requiring Bearer Token authentication, testing both with valid and invalid tokens. The test should ensure that the endpoint correctly handles token authentication, rejecting invalid tokens. Include dynamic data handling for bearer tokens to verify the system's resilience against different inputs. [response]: {
  "feature": "Bearer Token Authentication Validation",
  "scenario": "[ScenarioID]-[Scenario Name]",
  "steps": [
    "* url 'http://localhost:5000/secure/endpoint'",
    "* def generateToken = function() { return java.util.UUID.randomUUID().toString() },",
    "* def validBearerToken = 'bearer_' + generateToken(),",
    "* def invalidBearerToken = 'bearer_invalid',",
    "Given header Authorization = 'Bearer <validBearerToken>'",
    "When method GET",
    "Then status 200",
    "And match response contains 'Access granted with valid token.',",
    "* def invalidBearerTokenRequest = { header Authorization = 'Bearer <invalidBearerToken>' },",
    "Given request invalidBearerTokenRequest",
    "When method GET",
    "Then status 403",
    "And match response contains 'Invalid token.'"
  ]} [question]: Write a Karate DSL test for the `/secure/resource` endpoint requiring API key authentication, testing both with valid and invalid API keys. The test should ensure that the endpoint correctly handles API key authentication, rejecting invalid keys. Include dynamic data handling for API keys to verify the system's resilience against different inputs. [response]: {
  "feature": "API Key Authentication Validation",
  "scenario": "[ScenarioID]-[Scenario Name]",
  "steps": [
    "* url 'http://localhost:5000