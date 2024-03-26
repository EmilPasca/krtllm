{
  "feature": "[Feature Name] for BOLA and Auth Vulnerabilities",
  "scenario": "[ScenarioID]-[Scenario Name]",
  "steps": [
    "* url 'http://localhost:5000'",
    "* def generateToken = function() { return java.util.UUID.randomUUID().toString() },",
    "* def usernames = ['user1', 'user2', 'user3']",
    "* foreach usernames, function(username){",
    "    * def token = generateToken()",
    "    given path '/users/v1/{username}/email'",
    "    when method PUT",
    "    then status 200 or status 403",
    "    and match response contains 'Email updated successfully' if status == 200 else 'Access denied',",
    "  }"
  ]} [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "/oauth/refresh", "method": "POST", "summary": "Refreshes access and refresh tokens", "parameters": ["client_id", "client_secret"]}